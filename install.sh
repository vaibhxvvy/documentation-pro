#!/usr/bin/env bash
# documentation-pro — one-line installer
# Usage: curl -fsSL https://raw.githubusercontent.com/vaibhxvvy/documentation-pro/main/install.sh | bash

set -e

SKILL_NAME="documentation-pro"
REPO="vaibhxvvy/documentation-pro"
BRANCH="main"
RAW="https://raw.githubusercontent.com/${REPO}/${BRANCH}"
ARCHIVE="https://github.com/${REPO}/archive/refs/heads/${BRANCH}.tar.gz"

# ── colour ──────────────────────────────────────────────────────────────────
if [ -t 1 ] && command -v tput &>/dev/null; then
  BOLD="$(tput bold)"; RESET="$(tput sgr0)"
  GREEN="$(tput setaf 2)"; CYAN="$(tput setaf 6)"; RED="$(tput setaf 1)"; YELLOW="$(tput setaf 3)"
else
  BOLD=""; RESET=""; GREEN=""; CYAN=""; RED=""; YELLOW=""
fi

info()    { printf "${CYAN}  →${RESET} %s\n" "$*"; }
success() { printf "${GREEN}  ✓${RESET} %s\n" "$*"; }
warn()    { printf "${YELLOW}  ⚠${RESET} %s\n" "$*"; }
error()   { printf "${RED}  ✗${RESET} %s\n" "$*" >&2; exit 1; }
heading() { printf "\n${BOLD}%s${RESET}\n" "$*"; }

# ── detect OS ───────────────────────────────────────────────────────────────
OS="$(uname -s)"
case "$OS" in
  Linux*)   PLATFORM="Linux";;
  Darwin*)  PLATFORM="macOS";;
  CYGWIN*|MINGW*|MSYS*) PLATFORM="Windows";;
  *)        PLATFORM="Unknown";;
esac

# ── detect tools ────────────────────────────────────────────────────────────
has() { command -v "$1" &>/dev/null; }

if has curl; then
  FETCH="curl -fsSL"
elif has wget; then
  FETCH="wget -qO-"
else
  error "curl or wget required. Install one and retry."
fi

if ! has tar; then
  error "tar is required. Install it and retry."
fi

# ── resolve install locations ────────────────────────────────────────────────
# Anthropic Agent Skills Spec — all known discovery paths, in priority order.
# We install to ALL of them so the skill works in:
#   Claude Code, OpenCode, Cursor, Windsurf, Codex CLI, and any spec-compatible agent.

INSTALL_DIRS=()

# 1. OpenCode primary paths
[ -n "$XDG_CONFIG_HOME" ] && INSTALL_DIRS+=("$XDG_CONFIG_HOME/opencode/skills")
INSTALL_DIRS+=("$HOME/.config/opencode/skills")
INSTALL_DIRS+=("$HOME/.opencode/skills")

# 2. Claude Code path
INSTALL_DIRS+=("$HOME/.claude/skills")

# 3. Generic agents path (Windsurf, Cursor, etc.)
INSTALL_DIRS+=("$HOME/.agents/skills")

# Deduplicate and keep only writable-or-creatable paths
UNIQUE_DIRS=()
declare -A seen
for d in "${INSTALL_DIRS[@]}"; do
  [ "${seen[$d]+_}" ] && continue
  seen[$d]=1
  UNIQUE_DIRS+=("$d")
done

# ── banner ───────────────────────────────────────────────────────────────────
printf "\n"
printf "${BOLD}╔═══════════════════════════════════════════════════╗${RESET}\n"
printf "${BOLD}║     documentation-pro  v2.0.0 — Skill Installer  ║${RESET}\n"
printf "${BOLD}║     Technical Knowledge Publishing Framework      ║${RESET}\n"
printf "${BOLD}╚═══════════════════════════════════════════════════╝${RESET}\n\n"
info "Platform: $PLATFORM"
info "Skill: $SKILL_NAME"
info "Source: github.com/$REPO"

# ── download ─────────────────────────────────────────────────────────────────
heading "Downloading..."
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

info "Fetching archive from GitHub..."
$FETCH "$ARCHIVE" | tar -xz -C "$TMP" --strip-components=1
success "Downloaded"

# tar --strip-components=1 already strips the <repo>-<branch>/ wrapper.
# TMP is now the repo root. The skill package lives in documentation-pro/ subfolder.
SKILL_SRC="$TMP/documentation-pro"

[ -d "$SKILL_SRC" ] || error "Skill folder not found in archive"
[ -f "$SKILL_SRC/SKILL.md" ] || error "SKILL.md not found in archive — download may be corrupted"
success "Package verified"

# ── install ───────────────────────────────────────────────────────────────────
heading "Installing..."
INSTALLED_COUNT=0
FAILED_DIRS=()

for DIR in "${UNIQUE_DIRS[@]}"; do
  TARGET="$DIR/$SKILL_NAME"

  # Try to create parent dir
  if ! mkdir -p "$DIR" 2>/dev/null; then
    FAILED_DIRS+=("$DIR")
    continue
  fi

  # Remove old version if present
  [ -d "$TARGET" ] && rm -rf "$TARGET"

  # Copy skill
  if cp -r "$TMP" "$TARGET" 2>/dev/null; then
    INSTALLED_COUNT=$((INSTALLED_COUNT + 1))
    success "Installed → $TARGET"
  else
    FAILED_DIRS+=("$DIR (copy failed)")
  fi
done

# ── result ────────────────────────────────────────────────────────────────────
printf "\n"
if [ "$INSTALLED_COUNT" -eq 0 ]; then
  error "Installation failed — could not write to any skill directory."
fi

heading "Installation complete ✓"
printf "  Installed to ${BOLD}%d${RESET} location(s)\n\n" "$INSTALLED_COUNT"

if [ ${#FAILED_DIRS[@]} -gt 0 ]; then
  warn "Could not install to ${#FAILED_DIRS[@]} location(s):"
  for d in "${FAILED_DIRS[@]}"; do warn "  $d"; done
  printf "\n"
fi

printf "  The skill is available in:\n"
printf "  ${CYAN}Claude Code  |  OpenCode  |  Cursor  |  Windsurf  |  Codex CLI${RESET}\n\n"

printf "  ${BOLD}How to use:${RESET}\n"
printf "  Open any supported agent in your terminal or IDE and say:\n"
printf "  ${CYAN}\"Write a technical handbook on [topic]\"${RESET}\n"
printf "  ${CYAN}\"Generate API documentation for [service]\"${RESET}\n"
printf "  ${CYAN}\"Create a whitepaper about [subject]\"${RESET}\n\n"

printf "  ${BOLD}Restart your agent${RESET} to pick up the new skill.\n\n"
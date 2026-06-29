# documentation-pro — Windows PowerShell Installer
# Usage: irm https://raw.githubusercontent.com/vaibhxvvy/documentation-pro/main/install.ps1 | iex

$ErrorActionPreference = "Stop"

$SkillName  = "documentation-pro"
$Repo       = "vaibhxvvy/documentation-pro"
$Branch     = "main"
$Archive    = "https://github.com/$Repo/archive/refs/heads/$Branch.zip"

function Write-Step($msg) { Write-Host "  → $msg" -ForegroundColor Cyan }
function Write-OK($msg)   { Write-Host "  ✓ $msg" -ForegroundColor Green }
function Write-Warn($msg) { Write-Host "  ⚠ $msg" -ForegroundColor Yellow }
function Write-Fail($msg) { Write-Host "  ✗ $msg" -ForegroundColor Red; exit 1 }

Write-Host ""
Write-Host "╔═══════════════════════════════════════════════════╗" -ForegroundColor White
Write-Host "║     documentation-pro  v2.0.0 — Skill Installer  ║" -ForegroundColor White
Write-Host "║     Technical Knowledge Publishing Framework      ║" -ForegroundColor White
Write-Host "╚═══════════════════════════════════════════════════╝" -ForegroundColor White
Write-Host ""

# Install locations (all known agent skill directories on Windows)
$installDirs = @(
    "$env:APPDATA\OpenCode\skills",
    "$env:LOCALAPPDATA\OpenCode\skills",
    "$env:USERPROFILE\.config\opencode\skills",
    "$env:USERPROFILE\.opencode\skills",
    "$env:USERPROFILE\.claude\skills",
    "$env:USERPROFILE\.agents\skills"
)

# Download
Write-Host "Downloading..." -ForegroundColor White
$tmp = Join-Path $env:TEMP "documentation-pro-install-$(Get-Random)"
New-Item -ItemType Directory -Path $tmp -Force | Out-Null
$zipPath = Join-Path $tmp "skill.zip"

Write-Step "Fetching from GitHub..."
try {
    Invoke-WebRequest -Uri $Archive -OutFile $zipPath -UseBasicParsing
} catch {
    Write-Fail "Download failed: $_"
}

Write-Step "Extracting..."
$extractPath = Join-Path $tmp "extracted"
Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force

# GitHub extracts as: <repo>-<branch>/ containing the repo root
# The skill package is in the inner documentation-pro/ subfolder
$repoRoot = Get-ChildItem -Path $extractPath -Directory | Select-Object -First 1
if (-not $repoRoot) { Write-Fail "Extraction failed — archive may be corrupt" }

# The actual skill folder is repoRoot/documentation-pro/
$extracted = Get-Item (Join-Path $repoRoot.FullName "documentation-pro")
if (-not (Test-Path $extracted.FullName)) {
    Write-Fail "Skill folder not found inside archive"
}

# Verify SKILL.md
if (-not (Test-Path (Join-Path $extracted.FullName "SKILL.md"))) {
    Write-Fail "SKILL.md not found — package may be corrupt"
}
Write-OK "Package verified"

# Install
Write-Host ""
Write-Host "Installing..." -ForegroundColor White
$installed = 0
$failed    = @()

foreach ($dir in $installDirs) {
    try {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
        $target = Join-Path $dir $SkillName
        if (Test-Path $target) { Remove-Item $target -Recurse -Force }
        Copy-Item -Path $extracted.FullName -Destination $target -Recurse -Force
        Write-OK "Installed → $target"
        $installed++
    } catch {
        $failed += $dir
    }
}

# Cleanup
Remove-Item -Path $tmp -Recurse -Force -ErrorAction SilentlyContinue

# Result
Write-Host ""
if ($installed -eq 0) {
    Write-Fail "Installation failed — could not write to any skill directory"
}

Write-Host "Installation complete ✓" -ForegroundColor White
Write-Host "  Installed to $installed location(s)" -ForegroundColor White
Write-Host ""

if ($failed.Count -gt 0) {
    Write-Warn "Could not install to $($failed.Count) location(s)"
    $failed | ForEach-Object { Write-Warn "  $_" }
    Write-Host ""
}

Write-Host "  Works in: Claude Code | OpenCode | Cursor | Windsurf | Codex CLI" -ForegroundColor Cyan
Write-Host ""
Write-Host "  How to use:" -ForegroundColor White
Write-Host "  Open your agent and say:" -ForegroundColor Gray
Write-Host "  `"Write a technical handbook on [topic]`"" -ForegroundColor Cyan
Write-Host "  `"Generate API documentation for [service]`"" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Restart your agent to pick up the new skill." -ForegroundColor Yellow
Write-Host ""
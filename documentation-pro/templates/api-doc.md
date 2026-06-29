# API Reference Template

<!-- Copy this file to docs/api/endpoint-name.md and fill in all fields. -->
<!-- Every field marked (required) must be filled in. Fields marked (optional) -->
<!-- may be omitted only if genuinely not applicable. -->

## `[METHOD] /path/to/endpoint`

<!-- One sentence describing what this endpoint does. Active voice. Present tense. -->
<!-- Example: "Creates a new order and returns its identifier." -->

[One-sentence description. Required.]

**Introduced in**: v[X.Y] · **Status**: Stable | Beta | Deprecated

---

### Authentication

<!-- Describe exactly what credentials are required. -->

| Requirement | Value |
|---|---|
| Type | `Bearer token` \| `API key` \| `None` |
| Header | `Authorization: Bearer {token}` |
| Scope (if OAuth) | `orders:write` |

---

### Request

#### Path Parameters

| Parameter | Type | Description |
|---|---|---|
| `{id}` | string (UUID) | The unique identifier of the resource. |

#### Query Parameters

| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `limit` | integer | No | `20` | Number of results to return (1–100). |
| `cursor` | string | No | — | Pagination cursor from the previous response. |
| `include` | string[] | No | `[]` | Related resources to include. Values: `"items"`, `"metadata"`. |

#### Request Body

Content-Type: `application/json`

```json
{
  "name": "string",
  "quantity": 1,
  "metadata": {
    "key": "value"
  }
}
```

| Field | Type | Required | Constraints | Description |
|---|---|---|---|---|
| `name` | string | Yes | 1–200 chars | Human-readable name for the resource. |
| `quantity` | integer | Yes | 1–10,000 | Number of units to create. |
| `metadata` | object | No | Max 16 keys | Arbitrary key-value pairs for caller use. |

---

### Response

#### 200 OK — Success

```json
{
  "id": "ord_01HXYZ",
  "name": "Widget order",
  "quantity": 10,
  "status": "created",
  "created_at": "2024-03-15T14:30:00Z",
  "metadata": {}
}
```

| Field | Type | Description |
|---|---|---|
| `id` | string | Unique identifier. Prefix `ord_` followed by a ULID. |
| `name` | string | The name provided in the request. |
| `quantity` | integer | The quantity provided in the request. |
| `status` | string | Initial status. Always `"created"` on this endpoint. |
| `created_at` | string (ISO 8601) | UTC timestamp of creation. |
| `metadata` | object | The metadata provided in the request, or `{}` if none. |

#### 400 Bad Request — Validation error

Returned when the request body fails validation.

```json
{
  "error": "validation_failed",
  "message": "The 'quantity' field must be between 1 and 10,000.",
  "field": "quantity"
}
```

#### 401 Unauthorized

Returned when the `Authorization` header is missing or the token is invalid.

```json
{
  "error": "unauthorized",
  "message": "A valid bearer token is required."
}
```

#### 403 Forbidden

Returned when the authenticated caller lacks the required scope.

#### 409 Conflict

Returned when a resource with the same idempotency key already exists.

#### 429 Too Many Requests

```json
{
  "error": "rate_limited",
  "message": "Rate limit exceeded.",
  "retry_after": 30
}
```

Rate limit: **100 requests per minute** per API key. The `Retry-After` response
header indicates how many seconds to wait before retrying.

#### 500 Internal Server Error

Indicates an unexpected server-side error. Retry with exponential backoff.
Report persistent 500 errors to support with the `X-Request-ID` response header value.

---

### Example: Create an order

**Request**:

```bash
curl -X POST https://api.example.com/v1/orders \
  -H "Authorization: Bearer $API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Widget order",
    "quantity": 10
  }'
```

**Response** (201 Created):

```json
{
  "id": "ord_01HXYZ123456",
  "name": "Widget order",
  "quantity": 10,
  "status": "created",
  "created_at": "2024-03-15T14:30:00Z",
  "metadata": {}
}
```

---

### Notes

> **Note**: This endpoint is idempotent when the `Idempotency-Key` header is provided.
> Retrying a request with the same key returns the original response without creating
> a duplicate resource.

> **Warning**: Once an order reaches `"processing"` status, its `quantity` cannot
> be modified. Use the cancel endpoint to void the order.

---

### Changelog

| Version | Change |
|---|---|
| v2.1 | Added `metadata` field to request and response. |
| v2.0 | **Breaking**: `quantity` is now required (was optional with default 1). |
| v1.0 | Endpoint introduced. |

---

### See also

- `GET /v1/orders/{id}` — Retrieve an order by ID
- `PATCH /v1/orders/{id}` — Update an order
- `DELETE /v1/orders/{id}` — Cancel an order
- [Orders overview](../guides/orders.md)

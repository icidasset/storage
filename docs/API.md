## GET /maps

### Response:

- Status code 200
- Headers: []

- Supported content types are:

    - `application/json;charset=utf-8`
    - `application/json`

- Example (`application/json;charset=utf-8`, `application/json`):

```javascript
[]
```

- Example (`application/json;charset=utf-8`, `application/json`):

```javascript
[{"name":"Sample","id":1,"fields":"a,b,c"}]
```

- Example (`application/json;charset=utf-8`):

```javascript
[{"name":"Sample","id":1,"fields":"a,b,c"},{"name":"Sample","id":1,"fields":"a,b,c"}]
```

## POST /maps

### Request:

- Supported content types are:

    - `application/json;charset=utf-8`
    - `application/json`

- Example (`application/json;charset=utf-8`, `application/json`):

```javascript
{"name":"Sample","id":1,"fields":"a,b,c"}
```

### Response:

- Status code 200
- Headers: []

- Supported content types are:

    - `application/json;charset=utf-8`
    - `application/json`

- Example (`application/json;charset=utf-8`, `application/json`):

```javascript
{"name":"Sample","id":1,"fields":"a,b,c"}
```

## GET /maps/:map_id

### Captures:

- *map_id*: The `id` of the Map

### Response:

- Status code 200
- Headers: []

- Supported content types are:

    - `application/json;charset=utf-8`
    - `application/json`

- Example (`application/json;charset=utf-8`, `application/json`):

```javascript
{"name":"Sample","id":1,"fields":"a,b,c"}
```


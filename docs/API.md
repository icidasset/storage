## GET /maps

#### Authentication



Clients must supply the following data


#### Response:

- Status code 200
- Headers: []

- Supported content types are:

    - `application/json;charset=utf-8`
    - `application/json`

- 

```javascript
[]
```

- 

```javascript
[]
```

- Initial

```javascript
[{"id":1,"fields":[]}]
```

- Initial

```javascript
[{"id":1,"fields":[]}]
```

- Initial, Initial

```javascript
[{"id":1,"fields":[]},{"id":1,"fields":[]}]
```

## POST /maps

#### Authentication



Clients must supply the following data


#### Request:

- Supported content types are:

    - `application/json;charset=utf-8`
    - `application/json`

- Example (Initial): `application/json;charset=utf-8`

```javascript
{"id":1,"fields":[]}
```

- Example (Initial): `application/json`

```javascript
{"id":1,"fields":[]}
```

#### Response:

- Status code 200
- Headers: []

- Supported content types are:

    - `application/json;charset=utf-8`
    - `application/json`

- Initial

```javascript
{"id":1,"fields":[]}
```

- Initial

```javascript
{"id":1,"fields":[]}
```

## GET /maps/:map_id

#### Authentication



Clients must supply the following data


#### Captures:

- *map_id*: The `id` of the Map

#### Response:

- Status code 200
- Headers: []

- Supported content types are:

    - `application/json;charset=utf-8`
    - `application/json`

- Initial

```javascript
{"id":1,"fields":[]}
```

- Initial

```javascript
{"id":1,"fields":[]}
```


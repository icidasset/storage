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

- 

```javascript
[{"name":"Sample","id":1,"fields":"a,b,c"}]
```

- 

```javascript
[{"name":"Sample","id":1,"fields":"a,b,c"}]
```

- 

```javascript
[{"name":"Sample","id":1,"fields":"a,b,c"},{"name":"Sample","id":1,"fields":"a,b,c"}]
```

## POST /maps

#### Authentication



Clients must supply the following data


#### Request:

- Supported content types are:

    - `application/json;charset=utf-8`
    - `application/json`

- Example (): `application/json;charset=utf-8`

```javascript
{"name":"Sample","id":1,"fields":"a,b,c"}
```

- Example (): `application/json`

```javascript
{"name":"Sample","id":1,"fields":"a,b,c"}
```

#### Response:

- Status code 200
- Headers: []

- Supported content types are:

    - `application/json;charset=utf-8`
    - `application/json`

- 

```javascript
{"name":"Sample","id":1,"fields":"a,b,c"}
```

- 

```javascript
{"name":"Sample","id":1,"fields":"a,b,c"}
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

- 

```javascript
{"name":"Sample","id":1,"fields":"a,b,c"}
```

- 

```javascript
{"name":"Sample","id":1,"fields":"a,b,c"}
```


A REST API written in Haskell.


### Features

- Type-safe routing using `servant`
- Automatically generated API docs using `servant-docs`
- Easy db querying using `selda`
- Database migrations (partially using `selda`)
- Ensure existance of .env variables using `dotenv`


### How to use

```shell
# create a .env file
echo "PG_DATABASE=storage_experiment_dev" > .env

# create db and run migrations
make cli -- db:create
make cli -- db:migrate

# generate api docs
make docs

# start server
make server
```


### Issues

- Database migrations are not incremental


### To do

- Add timestamps to created records
- Add tests

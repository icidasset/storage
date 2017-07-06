Experimental API written in Haskell.


### Features

- Type-safe routing using `servant`
- Automatically generated API docs using `servant-docs`
- Easy db querying using `selda`
- Database migrations (partially using `selda`)


### How to use

```shell
# create postgresql db and run migrations
createdb "my_db"
"PG_DATABASE=my_db" > .env
make cli -- db:migrate

# generate api docs
make docs

# start server
make server
```


### Issues

- Database migrations are not incremental
- Some small issues with documentation generation (ie. double rendering of the examples)


### To do

- Add timestamps to created records

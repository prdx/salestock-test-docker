# salestock-test-docker

This docker has a submodule for the salestock-test.
This project has been tested to be able to run in Linux environtment.

## Requirements
- Docker
- Docker Compose

## Build
- docker-compose build
- docker-compose up
- In different terminal run: `docker-compose run web rake db:create db:migrate db:seed RAILS_ENV=production`

## Run test in docker
- You need to setup the database for test: `docker-compose run web rake db:create db:migrate db:seed RAILS_ENV=test`
- Run: `docker-compose run web bundle exec rspec`


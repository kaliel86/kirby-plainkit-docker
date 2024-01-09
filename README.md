# About this fork

This fork is an updated copy of the original Kirby plainkit with some dev tools added to make me start kirby projects
faster.

## Tooling

- Docker container for portable environment
- Vitejs for hot reload server and build SCSS, JS assets.

## Start using this fork

``git clone git@github.com:kaliel86/kirby-app.git``

``cd kirby-app``

``make dev``

PHP server is running on ``localhost:8096``, feel free to change it in docker-compose

To prevent errors form api requests, Kirby panel is accessible on ``localhost/panel`` without specifying port (port 80)


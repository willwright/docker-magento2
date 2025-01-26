# Docker + Magento2
## TLDR; *(Assumes Latest Version of Magento2)*
Clone this repo to your local machine.

Clone your source code to `magento` (relative to this repo).

Example:
If you cloned this repo to `www/docker-magento2` you would checkout your source to `www/docker-magento2/magento`.

Copy one of the `docker-compose-X.yaml` files to `docker-compose.yaml`.

Replace `local.magento2.com` with whatever your want your localhost to be called (whatever you set in your HOSTS file).

Open a terminal window `cd` to the directory which you checked this repo out to (`www/docker-magento2`) and run `docker-compose up`.  

## Documentation
This compose file has been built specifically for Magento 2.4.5

### Frontend
HAProxy (v2.6) -> Varnish (v7.0) -> nginx (1.18.0)

### Backend
* MariaDB (10.4)
* Redis (6.2)
* ElasticSearch (7.17)
* Kibana (7.17)

### Utilities
* Mailhog
* RedisCommander
* Kibana

## Configuration
If you want to use a different source directory you'll need to change the paths in `docker-compose.yaml`.

Data for MySQL is persisted in a Volume `mariadb`.

Data for ElasticSearch is persisted in a Volume `esdata`.

There are configuration files for _most_ of the services which are injected into the respective container. You can edit
these in order to configure a particular service to your specific needs.

### Fullstack
`docker-compose-fullstack.yaml`

This configuration provides everything necessary to run Magento locally using only Docker containers. This configuration 
does **not** use Varnish to help with faster development workflow.

Pros:
* All service needed to run Magento are provided by Docker
* Faster development cycle

Cons:
* Very slow file system performance on Windows (Mac and Linux might be useable)

### Fullstack + Varnish
`docker-compose-fullstack-varnish.yaml`

This configuration provides everything necessary to run Magento locally using only Docker containers. This configuration
**does** use Varnish in order to aid in developing against a full production stack.

Pros:
* All service needed to run Magento are provided by Docker
* Full stack debugging/testing

Cons:
* Very slow file system performance on Windows (Mac and Linux might be useable)
* Slower development cycle
* Varnish can obfuscate backend issues

### Hybrid
`docker-compose-fullstack-varnish.yaml`

This configuration provides _most_ services that are needed to run Magento locally. The web service is still your 
responsibility to provide the web service on the host machine.

Pros:
* Web service running locally results in fast file system operations
* Quickest development cycle

Cons:
* There is a large setup cost
* Networking between host and container network is complex

## Frequent Tasks
### Terminal into the web container to run Magento CLI

`docker ps`
Find the name of the web container, should be something like `docker-magento2_web_1`.

`docker exec -it docker-magento2_web_1 bash`

### Connect to DB
Open your favorite MySQL GUI.

Host: `127.0.0.1` or hostname your defined in `HOSTS`.

Port: `3306`

username: `root`

password: `password123` or your choice set in `db.environment.MYSQL_ROOT_PASSWORD`

catalog: `magento` or your choice set in `db.environment.MYSQL_DATABASE`

### Run XDEBUG
port: `9000`

idekey: `PHPSTORM`

### Kibana
Host: `127.0.0.1` or hostname your defined in `HOSTS`.

Port: 5601

### Import DB Dump
If you're working with a dump created by n98magerun then:

Place the db dump in a directory that is shared into the web container. For example `dev/magento` (using default `docker-compose.yaml`)

`docker exec -it docker-magento2_web_1 bash`

`n98magerun db:import mysqldump.sql`

If you have a dump from `mysqldump`:

`docker exec -it docker-magento2_web_1 bash`

`mysql -hdb -uroot -ppassword123 magento < magentodump.sql`

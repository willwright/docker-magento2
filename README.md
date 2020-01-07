# Docker + Magento2
## TLDR; *(Assumes Latest Version of Magento2)*
Clone this repo to your local machine.

Clone your source code to `dev/magento` (relative to this repo).

Example:
If you cloned this repo to `www/docker-magento2` you would checkout your source to `www/docker-magento2/dev/magento`.

Open `docker-compose.yaml` in your favorite text editor.

Replace `F:/www/docker-magento2/dev/magento` with the path to your source code.

Replace `local.magento2.com` with whatever your want your localhost to be called (whatever you set in your HOSTS file).

Open a terminal window `cd` to the directory which you checked this repo out to (`www/docker-magento2`) and run `docker-compose up`.  

## Documentation

### Frontend
HAProxy (v1.9) -> Varnish (v6.3) -> Apache2 (2.4)

### Backend
* Percona (5.7)
* Redis (5.0)
* ElasticSearch (6.8)
* Kibana (6.8)

## Configuration
If you want to use a different directory that's fine, but you'll need to change the paths in `docker-compose.yaml`.

Data for MySQL is persisted in a Volume `mysqldb`.

Data for ElasticSearch is persisted in a Volume `esdata1`.

### Fast
There is a "fast" configuration pre-configured in `docker-compose-fast.yaml`.  To use this configuration either specify
the file specifically when running `docker-compose up` or change the file name.

This configuration requires that you run `docker-compose build` prior to starting the stack.

This configuration *only* mounts the directories that are used for __most__ development activities, thus speeding
up the entire stack.

### Docker Sync
There is a pre-configured YAML for using `docker-sync` in `docker-compose-docker-sync.yaml`.  To use this configuration either specify
the file specifically when running `docker-compose up` or change the file name.

This configuration requires that you install and configure `docker-sync`. This configuration is intended to be used with 
`docker-sync.yml`.

SEE: http://docker-sync.io for installation instructions.

### Docker Sync App Only
There is a pre-configured YAML for using `docker-sync` in `docker-compose-docker-sync.yaml`.  To use this configuration either specify
the file specifically when running `docker-compose up` or change the file name.

This configuration requires that you install and configure `docker-sync`. This configuration is intended to be used with 
`docker-sync-app-only.yml`.

SEE: http://docker-sync.io for installation instructions.
This configuration requires that you run `docker-compose build` prior to starting the stack.

This configuration *only* mounts the directories that are used for __most__ development activities, thus speeding
up the entire stack.

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

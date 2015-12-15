# XtremXpert Alternative phpMyAdmin Docker image

Based on the official phpmyamdin:phpmyadmin but:
- change alpine to latest (not sure of any impact) 
- add ENV var for localisation
- add ntp
- add mc, nano and set TERM (ease of use)

Run phpMyAdmin with Alpine and PHP built in web server.

All following examples will bring you phpMyAdmin on `http://localhost:8080`
where you can enjoy your happy MySQL administration.

## Usage with linked server

First you need to run MySQL or MariaDB server in Docker, and this image need
link a running mysql instance container:

```
docker run --name myadmin -d --link mysql_db_server:db -p 8080:8080 phpmyadmin/phpmyadmin
```

## Usage with external server

You can specify MySQL host in the `PMA_HOST` environment variable. You can also
use `PMA_PORT` to specify port of the server in case it's not the default one:

```
docker run --name myadmin -d -e PMA_HOST=dbhost -p 8080:8080 phpmyadmin/phpmyadmin
```

## Usage with arbitrary server

You can use arbitrary servers by adding ENV variable `PMA_ARBITRARY=1` to the startup command:

```
docker run --name myadmin -d --link mysql_db_server:db -p 8080:8080 -e PMA_ARBITRARY=1 phpmyadmin/phpmyadmin
```

## Usage with docker-compose and arbitrary server

This will run phpMyAdmin with arbitrary server - allowing you to specify MySQL/MariaDB
server on login page.

Using the docker-compose.yml from https://github.com/phpmyadmin/docker

```
docker-compose up -d
```

## Environment variables summary

* ``PMA_ARBITRARY`` - when set to 1 connection to the arbitrary server will be allowed
* ``PMA_HOST`` - define address/host name of the MySQL server
* ``PMA_PORT`` - define port of the MySQL server
* ``PMA_HOSTS`` - define comma separated list of address/host names of the MySQL servers
* ``PMA_USER`` and ``PMA_PASSWORD`` - define username to use for config authentication method

## Added Environment variables 

* ``LANG`` - Change for your language default to fr_CA.UTF-8
* ``LC_ALL`` - Change for your language default to fr_CA.UTF-8
* ``LANGUAGE`` - Change for your language default to fr_CA.UTF-8
* ``TZ`` - Your time zone default to America/Toronto
* ``TERM`` - For nano and mc, set to xterm

FROM mariadb:10.4

ENV MARIADB_ROOT_PASSWORD=password
ENV MARIADB_DATABASE=db_yii2
ENV MARIADB_USER=user_yii2
ENV MARIADB_PASSWORD=password

COPY ./init_db_jii2.sql /docker-entrypoint-initdb.d/

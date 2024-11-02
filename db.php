<?php

return [
    'class' => 'yii\db\Connection',
    'dsn' => 'mysql:host=db;dbname=${MARIADB_DATABASE}',
    'username' => '${MARIADB_USER}',
    'password' => '${MARIADB_PASSWORD}',
    'charset' => 'utf8',
];

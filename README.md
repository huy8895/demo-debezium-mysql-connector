# debezium CDC demo

## 1. setup

- start
```shell
docker compose  -f ./unwrap-smt/docker-compose-jdbc.yaml -p unwrap-smt up -d
```

- stop
```shell
docker compose  -f ./unwrap-smt/docker-compose-jdbc.yaml -p unwrap-smt down --remove-orphans --volumes
```
## 2. create source connector
### 2.1 mysql connector
```shell
curl --location 'localhost:8083/connectors' \
--data '{
    "name": "inventory-connector-customer",
    "config": {
        "connector.class": "io.debezium.connector.mysql.MySqlConnector",
        "tasks.max": "1",
        "topic.prefix": "inventory-connector-customer",
        "database.hostname": "mysql",
        "database.port": "3306",
        "database.user": "root",
        "database.password": "debezium",
        "database.server.id": "374",
        "database.include.list": "inventory",
        "table.include.list": "inventory.customers",
        "schema.history.internal.kafka.bootstrap.servers": "kafka:9092",
        "schema.history.internal.kafka.topic": "schema-changes.inventory",
        "transforms": "route",
        "transforms.route.type": "org.apache.kafka.connect.transforms.RegexRouter",
        "transforms.route.regex": "([^.]+)\\.([^.]+)\\.([^.]+)",
        "transforms.route.replacement": "$1_$2_$3"
    }
}'
```

### 2.2 oracle connector
```shell
curl --location 'localhost:8083/connectors/' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "GENERALINFO_SIT-connector",
    "config": {
        "connector.class": "io.debezium.connector.oracle.OracleConnector",
        "tasks.max": "1",
        "database.url": "jdbc:oracle:thin:@//10.0.64.138:1521/bpm",
        "database.driverClassName": "oracle.jdbc.OracleDriver",
        "database.port": "1521",
        "database.user": "GeneralInfo",
        "database.password": "GeneralInfo_Dev_2021",
        "database.dbname": "bpm",
        "topic.prefix": "generalinfo_sit",
        "schema.history.internal.kafka.bootstrap.servers": "kafka:9092",
        "schema.history.internal.kafka.topic": "schemahistory.sit.GeneralInfo",
        "database.server.name": "server1",
        "schema.include.list": "GENERALINFO",
        "table.include.list":"GENERALINFO.GENERAL_INFO",
        "event.processing.failure.handling.mode": "warn",
        "inconsistent.schema.handling.mode": "warn",
        "database.history.store.only.captured.tables.ddl": true,
        "schema.history.internal.store.only.captured.tables.ddl": true ,
        "database.server.id": "111",
        "transforms": "route",
        "transforms.route.type": "org.apache.kafka.connect.transforms.RegexRouter",
        "transforms.route.regex": "([^.]+)\\.([^.]+)\\.([^.]+)",
        "transforms.route.replacement": "$1_$2_$3"
    }
}'
```

## 3. create sink connector
### 3.1 mysql sink connector
```shell
curl --location 'localhost:8083/connectors' \
--data '{
    "name": "mysql-sink-inventory.customers",
    "config": {
        "connector.class": "io.confluent.connect.jdbc.JdbcSinkConnector",
        "tasks.max": "1",
        "topics": "inventory-connector-customer_inventory_customers",
        "connection.url": "jdbc:mysql://mysql:3306/inventory?useSSL=false",
        "connection.user": "root",
        "connection.password": "debezium",
        "transforms": "unwrap",
        "transforms.unwrap.type": "io.debezium.transforms.ExtractNewRecordState",
        "transforms.unwrap.drop.tombstones": "false",
        "auto.create": "true",
        "insert.mode": "upsert",
        "delete.enabled": "true",
        "pk.fields": "id",
        "pk.mode": "record_key",
        "dialect.name": "MySqlDatabaseDialect"
    }
}'
```

### 3.2 postgres sink connector
```shell
curl --location 'localhost:8083/connectors' \
--data '{
    "name": "mysql-sink",
    "config": {
        "connector.class": "io.confluent.connect.jdbc.JdbcSinkConnector",
        "tasks.max": "1",
        "topics": "your-topic-name",
        "connection.url": "jdbc:mysql://mysql-sink:3307/inventory?user=mysqluser&password=mysqlpw",
        "transforms": "unwrap",
        "transforms.unwrap.type": "io.debezium.transforms.ExtractNewRecordState",
        "transforms.unwrap.drop.tombstones": "false",
        "auto.create": "true",
        "insert.mode": "upsert",
        "delete.enabled": "true",
        "pk.fields": "id",
        "pk.mode": "record_key",
        "auto.evolve": true
    }
}
'
```
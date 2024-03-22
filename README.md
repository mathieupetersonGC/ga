# Introduction
This project is a test to for the GoAnywhere container

# Container Image Build
Run the following commands from {project root directory}/git/ga:
```
docker build -t myga:latest .
```

# Run Instructions
## Environment Variables

The following environment variables are used to control the application at run-time. Mandatory variables are marked with an asterisk.

> **MFT_CLUSTER**: Enables cluster for the application.
- Allowed values: TRUE or FALSE
- Default value: FALSE

> **SYSTEM_NAME**: The name for the application used in the cluster.
- Default value: none

> **DB_PASSWORD**: The password used by the application to connect to the database server.
- Default value: none

> **DB_USERNAME**: The username used by the application to connect to the database server.
- Default value: none

> **DB_DRIVERCLASSNAME**: The driver class name used by the application to connect to the database server.
- Default value: none
- Allowed values: 
    - mariaDB:org.mariadb.jdbc.Driver

> **DB_URL**: The connection string to connect to the database server.
- Default value: none

> JAVA_MAX_MEMORY: The java memory required for the application.
- Default value: 1024
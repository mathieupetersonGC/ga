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
- Unique: true

> **DB_PASSWORD**: The password used by the application to connect to the database server.
- Default value: none

> **DB_USERNAME**: The username used by the application to connect to the database server.
- Default value: none

> **DB_URL**: The connection string to connect to the database server.
- Default value: none

> JAVA_MAX_MEMORY: The java memory required for the application.
- Default value: 1024

# Configurations
## Setting Up Initial System
The initial setup needs to be in a non-clustered environment using the default derby DB.

After the first boot:
1.  Login to the application UI.
2.  Choose the Online license.
3.  Create the initial admin local account.
4.  Go in System -> Database administration -> Switch database.
5.  Fill in the new DB information.
    1.  NB, the options you choose will be different depending if you already have a DB with data (backup) or if you are setting it up for the first time.
6.  Once the DB switched, restart the container.
7.  Login to the application UI.
8.  Verify that that the system database is now pointing to the new DB.
9.  Update the following paths to your shared folder:
    1.  Navigate to the System > Global Settings page. On the Data tab, specify the shared network folders for each feature.
    2.  Navigate to the Users > Domains page. Review each Domain's Projects, Workspace, and WebDocs directories to ensure each server in the cluster can reach the specified folders.
    3.  Navigate to the Services > Secure Forms Settings page and configure the Secure Forms Directory to point to a shared network folder.
    4.  Navigate to the Reporting > Global Log Settings page and configure the Logs Directory to point to a shared network folder.
    5.  Navigate to the Services > GoDrive Settings page and configure GoDrive Directory to point to a shared network folder.
    6.  Navigate to the Help > Software Library page and configure the settings. The Software Storage Location must point to a shared network folder.
    7.  If you are using the Key Management System, keys and certificates are stored in the GoAnywhere database and there is no configuration change necessary for clustering. 
    8.  If you are using file-based keys and certificates, then the locations of the PGP Key Rings or SSL Key Stores should point to a shared network location that all systems in the cluster have access to. To specify the Key locations:
        1.  For SSL, select Encryption from the main menu and choose the File Based Keys > Certificates option, and then select Preferences. Specify the shared network locations for the key stores on the Default Trusted Certificates and Default Private Keys.
        2.  For PGP, select Encryption from the main menu and choose the File Based Keys > PGP Keys option, and then select Preferences. Specify the shared network locations for the key rings on the Default Public Key Ring and Default Secret Key Ring. GoAnywhere MFT User Guide www.goanywhere.com page: 3160 System / Clustering

You now have a functional GoAnywhere instance running on a DB with shared folder.

## Setting up a cluster
1.  Shut down the GoAnywhere service.
2.  Update the environment variable {{MFT_CLUSTER}} and set to true for each instance you plan on running.
3.  Start the containers in order not simultaneously.
4.  Once the services are started, login to the application UI.
5.  Go in system --> Cluster manager.
6.  You should now see all your services.

# Resources
https://my.goanywhere.com/

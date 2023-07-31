<!-- #region -->
## <span style='color:#ff5f27'> 👨🏻‍🏫 DBT Tutorial with BigQuery </span>

This tutorial shows you how to perform feature engineering in DBT on BigQuery, storing offline computed features in a table in BigQuery (that is mounted as an external feature group in Hopsworks) and online features in Hopsworks. The online features are written to Hopsworks using a Python module that is run on a DataProc cluster. The feature group created in Hopsworks has its offline data stored in BigQuery and its online data stored in Hopsworks online store (RonDB).

### <span style='color:#ff5f27'> 🔮 Hopsworks BigQuery Storage Connector Setup </span>

Follow this [guide](https://docs.hopsworks.ai/3.0/user_guides/fs/storage_connector/creation/bigquery/) to set up a connection to BigQuery.

### <span style='color:#ff5f27'> 🏡 Dataproc Cluster Setup </span>

First, you need to setup a Dataproc (Spark) cluster that will run the Python model in our DBT workflow. The Python model will write to the online feature store in Hopsworks.

Dataproc cluster needs to be deployed in the same subnet as Hopsworks or Hopsworks and Dataproc networks needs to be VPC peered so that resources in each network can communicate with each other. (You can read more about VPC-Peering [here](https://cloud.google.com/vpc/docs/vpc-peering))

Navigate to **Project Settings** and then **Integrations**. At the bottom of the page you will find necessary files which you need to attach to your Dataproc cluster.

![output](images/sparkConfig.png)

You need to untar the downloaded archive and upload the resulting files to your GCS bucket.

In addition, upload downloaded certificates to the **client** folder where JARs are located.

You can find the code to create the Dataproc cluster in `provision.sh`.

To make `provision.sh` file executable, run the following command:

`chmod +x provision.sh`

You can find the code to configure your Spark in `configureSpark.sh`. Fill in your information and upload `configureSpark.sh` to your GCS bucket.

Fill in your cluster information and then run the `./provision.sh` command.

### <span style='color:#ff5f27'>👩🏻‍🔬 GCP Service account setup </span>

To create a service account follow the next navigation: IAM & Admin → Service Accounts → Create Service Account.

Grant your service account the next roles:

- BigQuery Admin
- Dataproc Administrator
- Editor
- Storage Admin


### <span style='color:#ff5f27'>📡 DBT Setup </span>

Install the BigQuery adapter by running
`pip install dbt-bigquery`

Create a new profile inside your ~/.dbt/profiles.yml file.

```
{YOUR_DBT_PROJECT_NAME}:
 target: dev
 outputs:
   dev:
     # Type of DBT connector (BigQuery, Snowflake, etc)
     type: bigquery
     # Authentication method 
     method: service-account-json
     # Your Google Cloud project id
     project: [YOUR_GCP_PROJECT_ID]
     # Your BigQuery dataset name
     dataset: {YOUR_DATASET_NAME}
     threads: 1


     # These fields come from the service account json keyfile
     keyfile_json:
       type: xxx
       project_id: xxx
       private_key_id: xxx
       private_key: xxx
       client_email: xxx
       client_id: xxx
       auth_uri: xxx
       token_uri: xxx
       auth_provider_x509_cert_url: xxx
       client_x509_cert_url: xxx


     # Your Bucket name
     gcs_bucket: {YOUR_BUCKET_NAME}
     # Your Dataproc region
     dataproc_region: {YOUR_DATAPROC_REGION} 
 ```


### <span style='color:#ff5f27'>⚙️ DBT Launch </span>

Fill in `read_bigquery_data.sql`, `data_pipeline.py` and `schedule_pipeline.py` files with your feature engineering code that creates features and writes them to the BQ offline table and Hopsworks online table.

Use the next command to run DBT models pipeline:

`dbt run`

You will see the next output:
![output](images/output.png)

> To see the job logs, check your cluster **Job details**.

## <span style='color:#ff5f27'>🗓️ DBT Scheduling </span>

To schedule a DBT model you will use the DBT Cloud Platform.

To begin with, register on the [DBT Cloud page](https://cloud.getdbt.com).

Next, you need to set up a new project. Name it and press continue.

Choose the BigQuery connection.

Then upload your **Service Account JSON file**, define a Google Cloud **Storage Bucket name**, **Dataproc Region** and **Dataproc Cluster name**.

Press **Test Connection**.

To setup a repository, select GitHub option and choose a repository with your DBT tutorial project.

Great! Your project is ready!📈

### <span style='color:#ff5f27'>⏰ Cloud Scheduler set up </span>

The last step is to create a scheduled job, that will invoke our Cloud Run service

First, we need to create a service account for this.

Navigate to IAM & Admin → Service Accounts → Create Service Account.

Name your account and grant the next Roles:
- Cloud Run Invoker
- Cloud Run Service Agent

Now go to Cloud Scheduler and press **Create a new job**.

Name your schedule, select your region, add a description and use `'0 0 * * *'` cron expression to run job at 00:00 (midnight) every day.

Configure the job execution:
- **Target Type** - HTTP.
- Enter your Cloud Run URL
- Choose GET method for HTTP requests
- Choose Add OIDC token
- Enter service account email that you’ve created
- Enter your Cloud Run URL

![config_image](images/config.png)

After creation, select created job and press **Force Run**.
<!-- #endregion -->

```python

```

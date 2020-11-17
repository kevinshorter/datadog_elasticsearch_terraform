# Datadog Terraform Elasticsearch

Create Datadog monitors for Elasticsearch with Terraform.

The Terraform provider [datadog/datadog](https://registry.terraform.io/providers/DataDog/datadog/latest/docs) is required.


## Pre-requisits

API and APP keys are setup in Datadog here
  - EU https://app.datadoghq.eu/account/settings#api
  - US https://app.datadoghq.com/account/settings#api

Expose environment variables.

```bash
export DD_API_KEY=xxxxxxxxxxxxxxxxxx
export DD_APP_KEY=yyyyyyyyyyyyyyyyyy
export DD_HOST=https://api.datadoghq.eu/    (or https://api.datadoghq.com/ for USA)
export TF_VAR_cluster_name=my_es_cluster    (this is optional, also set in variables.tf)
```

Datadog agent needs to be configured to [send ES metrics](https://docs.datadoghq.com/integrations/elastic/?tab=host).
Also the Elasticsearch integration needs to be added to Datadog. This [guide](https://www.datadoghq.com/blog/monitor-elasticsearch-datadog/) covers all of that.


## Create monitor

```bash
terraform init
terraform plan
terraform apply
```


## Delete monitor

```
terraform destroy
```

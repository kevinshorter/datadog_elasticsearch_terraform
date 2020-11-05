terraform {
  required_version = ">= 0.12.24"
  required_providers {
    datadog = {
      # datadog provider: https://www.terraform.io/docs/providers/datadog/index.html
      # define DATADOG_API_KEY and DATADOG_APP_KEY in environment variables
      source  = "datadog/datadog"
      datadog = "~> 2.14"
    }
  }
}

resource "datadog_monitor" "es_cluster_health" {
  name              = "Elasticsearch cluster health status - ${var.cluster_name}"
  type              = "service check"
  query             = "\"elasticsearch.cluster_health\".over(\"cluster_name:${var.cluster_name}\").by(\"cluster_name\").last(2).count_by_status()"
  message           = <<EOF
    ES cluster ${var.cluster_name} is unhealthy.
  
    Probably best to check it out.
  EOF
  tags              = var.es_mon.tags
  notify_audit      = var.es_mon.notify_audit
  locked            = var.es_mon.locked
  timeout_h         = var.es_mon.timeout_h
  include_tags      = var.es_mon.include_tags
  new_host_delay    = var.es_mon.new_host_delay
  notify_no_data    = var.es_mon.notify_no_data
  renotify_interval = var.es_mon.renotify_interval
  no_data_timeframe = var.es_mon.no_data_timeframe
  thresholds = {
    ok       = var.es_mon.thresholds_ok
    warning  = var.es_mon.thresholds_warning
    critical = var.es_mon.thresholds_critical
  }
}

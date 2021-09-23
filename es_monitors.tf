terraform {
  required_version = ">= 0.12.24"
  required_providers {
    datadog = {
      # datadog provider: https://www.terraform.io/docs/providers/datadog/index.html
      # define DD_API_KEY and DD_APP_KEY in environment variables
      source  = "datadog/datadog"
      datadog = "~> 2.14"
    }
  }
}

resource "datadog_monitor" "es_cluster_health" {
  name              = "Elasticsearch cluster health status - ${var.cluster_name}"
  type              = "service check"
  query             = "\"elasticsearch.cluster_health\".over(\"cluster_name:${var.cluster_name}\").by(\"cluster_name\").last(${var.es_mon.thresholds_critical + 1}).count_by_status()"
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

resource "datadog_monitor" "es_number_of_nodes" {
  name              = "Elasticsearch number of nodes - ${var.cluster_name}"
  type              = "metric alert"
  query             = "avg(last_${var.es_mon.trigger_duration_mins}m):avg:elasticsearch.number_of_nodes{cluster_name:${var.cluster_name}} < ${var.es_mon_nodes.thresholds_critical}"
  message           = <<EOF
    ES cluster ${var.cluster_name} number of nodes {{value}}.

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
    ok       = var.es_mon_nodes.thresholds_ok
    warning  = var.es_mon_nodes.thresholds_warning
    critical = var.es_mon_nodes.thresholds_critical
  }
}

resource "datadog_monitor" "es_thread_pool_search_queue" {
  name              = "Elasticsearch thread pool search queue - ${var.cluster_name}"
  type              = "metric alert"
  query             = "avg(last_${var.es_mon.trigger_duration_mins}m):avg:elasticsearch.thread_pool.search.queue{cluster_name:${var.cluster_name}} by {node_name} > ${var.es_mon_thread_pool_search_queue.thresholds_critical}"
  message           = <<EOF
    ES cluster ${var.cluster_name} thread pool search queue {{value}}.

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
    ok       = var.es_mon_thread_pool_search_queue.thresholds_ok
    warning  = var.es_mon_thread_pool_search_queue.thresholds_warning
    critical = var.es_mon_thread_pool_search_queue.thresholds_critical
  }
}

resource "datadog_monitor" "es_thread_pool_write_queue" {
  name              = "Elasticsearch thread pool write queue - ${var.cluster_name}"
  type              = "metric alert"
  query             = "avg(last_${var.es_mon.trigger_duration_mins}m):avg:elasticsearch.thread_pool.write.queue{cluster_name:${var.cluster_name}} by {node_name} > ${var.es_mon_thread_pool_write_queue.thresholds_critical}"
  message           = <<EOF
    ES cluster ${var.cluster_name} thread pool write queue {{value}}.

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
    ok       = var.es_mon_thread_pool_write_queue.thresholds_ok
    warning  = var.es_mon_thread_pool_write_queue.thresholds_warning
    critical = var.es_mon_thread_pool_write_queue.thresholds_critical
  }
}

resource "datadog_monitor" "es_pending_tasks_total" {
  name              = "Elasticsearch pending tasks total - ${var.cluster_name}"
  type              = "metric alert"
  query             = "avg(last_${var.es_mon.trigger_duration_mins}m):avg:elasticsearch.pending_tasks_total{cluster_name:${var.cluster_name}} > ${var.es_mon_pending_tasks_total.thresholds_critical}"
  message           = <<EOF
    ES cluster ${var.cluster_name} pending tasks total {{value}}.

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
    ok       = var.es_mon_pending_tasks_total.thresholds_ok
    warning  = var.es_mon_pending_tasks_total.thresholds_warning
    critical = var.es_mon_pending_tasks_total.thresholds_critical
  }
}

resource "datadog_monitor" "es_pending_tasks_priority_high" {
  name              = "Elasticsearch pending tasks priority high - ${var.cluster_name}"
  type              = "metric alert"
  query             = "avg(last_${var.es_mon.trigger_duration_mins}m):avg:elasticsearch.pending_tasks_priority_high{cluster_name:${var.cluster_name}} > ${var.es_mon_pending_tasks_priority_high.thresholds_critical}"
  message           = <<EOF
    ES cluster ${var.cluster_name} pending tasks priority high {{value}}.

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
    ok       = var.es_mon_pending_tasks_priority_high.thresholds_ok
    warning  = var.es_mon_pending_tasks_priority_high.thresholds_warning
    critical = var.es_mon_pending_tasks_priority_high.thresholds_critical
  }
}

resource "datadog_monitor" "es_pending_tasks_priority_urgent" {
  name              = "Elasticsearch pending tasks priority urgent - ${var.cluster_name}"
  type              = "metric alert"
  query             = "avg(last_${var.es_mon.trigger_duration_mins}m):avg:elasticsearch.pending_tasks_priority_urgent{cluster_name:${var.cluster_name}} > ${var.es_mon_pending_tasks_priority_urgent.thresholds_critical}"
  message           = <<EOF
    ES cluster ${var.cluster_name} pending tasks priority urgent {{value}}.

    Triage: 

    @opsgenie-OpsGenie-PaaS-Data-Services
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
    ok       = var.es_mon_pending_tasks_priority_urgent.thresholds_ok
    warning  = var.es_mon_pending_tasks_priority_urgent.thresholds_warning
    critical = var.es_mon_pending_tasks_priority_urgent.thresholds_critical
  }
}

resource "datadog_monitor" "es_indexing_index_total" {
  name              = "Elasticsearch indexing index total - ${var.cluster_name}"
  type              = "metric alert"
  query             = "avg(last_${var.es_mon.trigger_duration_mins}m):avg:elasticsearch.indexing.index.total{cluster_name:${var.cluster_name}} > ${var.es_mon_indexing_index_total.thresholds_critical}"
  message           = <<EOF
  ES cluster ${var.cluster_name} indexing index total {{value}}.

  Triage: 

  @opsgenie-OpsGenie-PaaS-Data-Services
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
    ok       = var.es_mon_indexing_index_total.thresholds_ok
    warning  = var.es_mon_indexing_index_total.thresholds_warning
    critical = var.es_mon_indexing_index_total.thresholds_critical
  }
}

resource "datadog_monitor" "es_thread_pool_bulk_rejected" {
  name              = "Elasticsearch thread pool bulk rejected - ${var.cluster_name}"
  type              = "metric alert"
  query             = "avg(last_${var.es_mon.trigger_duration_mins}m):avg:elasticsearch.thread_pool.bulk.rejected{cluster_name:${var.cluster_name}} by {node_name} > ${var.es_mon_thread_pool_bulk_rejected.thresholds_critical}"
  message           = <<EOF
    ES cluster ${var.cluster_name} thread pool bulk rejected {{value}}.

    Triage: 

    @opsgenie-OpsGenie-PaaS-Data-Services
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
    ok       = var.es_mon_thread_pool_bulk_rejected.thresholds_ok
    warning  = var.es_mon_thread_pool_bulk_rejected.thresholds_warning
    critical = var.es_mon_thread_pool_bulk_rejected.thresholds_critical
  }
}

# elasticsearch datadog monitor vars

# if running in a pipeline pass the elasticsearch cluster_name to this module using the environment variable TF_VAR_cluster_name
variable cluster_name {
  default = "elasticsearch"
}

variable es_mon {
  description = "ES monitor properties"
  type = object({
    include_tags          = bool         # include additionl tag information in the subject of the alert
    locked                = bool         # allow changes outside of the pipleine and automation
    new_host_delay        = number       # delay monitoring for new resoruces for a period of time
    no_data_timeframe     = number       # timeframe to wait for new data before an alert triggers
    notify_audit          = bool         # notify when a monitor is changed
    notify_no_data        = bool         # notifies if there is no data for a monitored resource
    renotify_interval     = number       # time to wait to re-send alert
    require_full_window   = bool         # require a full window of data before the monitor can trigger
    tags                  = list(string) # list of tags
    thresholds_ok         = number       # threshold for OK
    thresholds_warning    = number       # threshold for WARNING
    thresholds_critical   = number       # threshold for CRITICAL
    timeout_h             = number       # the number of hours of the monitor not reporting data before it will automatically resolve; 0 means never timeout
    trigger_duration_mins = number       # trigger duration in minutes
  })
  default = {
    include_tags          = false
    locked                = true
    new_host_delay        = 60
    no_data_timeframe     = 10
    notify_audit          = false
    notify_no_data        = true
    renotify_interval     = 30
    require_full_window   = true
    tags                  = ["managed-by:terraform", "team: kgs"]
    thresholds_ok         = 1
    thresholds_warning    = 2
    thresholds_critical   = 3
    timeout_h             = 0
    trigger_duration_mins = 5
  }
}

variable es_mon_nodes {
  description = "es_number_of_nodes"
  type = object({
    thresholds_ok       = number
    thresholds_warning  = number
    thresholds_critical = number
  })
  default = {
    thresholds_ok       = 4
    thresholds_warning  = 3
    thresholds_critical = 2
  }
}

variable es_mon_thread_pool_search_queue {
  description = "es_thread_pool_search_queue"
  type = object({
    thresholds_ok       = number
    thresholds_warning  = number
    thresholds_critical = number
  })
  default = {
    thresholds_ok       = 100
    thresholds_warning  = 500
    thresholds_critical = 1000
  }
}

variable es_mon_thread_pool_write_queue {
  description = "es_thread_pool_write_queue"
  type = object({
    thresholds_ok       = number
    thresholds_warning  = number
    thresholds_critical = number
  })
  default = {
    thresholds_ok       = 100
    thresholds_warning  = 500
    thresholds_critical = 1000
  }
}

variable es_mon_pending_tasks_total {
  description = "es_pending_tasks_total"
  type = object({
    thresholds_ok       = number
    thresholds_warning  = number
    thresholds_critical = number
  })
  default = {
    thresholds_ok       = 0
    thresholds_warning  = 5
    thresholds_critical = 10
  }
}

variable es_mon_pending_tasks_priority_high {
  description = "es_pending_tasks_priority_high"
  type = object({
    thresholds_ok       = number
    thresholds_warning  = number
    thresholds_critical = number
  })
  default = {
    thresholds_ok       = 0
    thresholds_warning  = 5
    thresholds_critical = 10
  }
}

variable es_mon_pending_tasks_priority_urgent {
  description = "es_pending_tasks_priority_urgent"
  type = object({
    thresholds_ok       = number
    thresholds_warning  = number
    thresholds_critical = number
  })
  default = {
    thresholds_ok       = 0
    thresholds_warning  = 5
    thresholds_critical = 10
  }
}

variable es_mon_indexing_index_total {
  description = "es_indexing_index_total"
  type = object({
    thresholds_ok       = number
    thresholds_warning  = number
    thresholds_critical = number
  })
  default = {
    thresholds_ok       = 0
    thresholds_warning  = 5
    thresholds_critical = 10
  }
}

variable es_mon_thread_pool_bulk_rejected {
  description = "es_thread_pool_bulk_rejected"
  type = object({
    thresholds_ok       = number
    thresholds_warning  = number
    thresholds_critical = number
  })
  default = {
    thresholds_ok       = 100
    thresholds_warning  = 500
    thresholds_critical = 1000
  }
}

#----------------------------#
#   INSTANCE SPECIFICATION   #
#----------------------------#

resource "google_sql_database_instance" "read_replica" {
  count = var.read_replica ? 1 : 0

  name                 = "${var.instance_name_without_version}-replica-v${var.map_major_version[var.engine_version]}"
  region               = var.region
  database_version     = var.engine_version
  master_instance_name = google_sql_database_instance.master.name

  #------------------------------------------------#
  #   INSTANCE SPECIFICATION / INSTANCE SETTINGS   #
  #------------------------------------------------#

  settings {
    tier            = var.read_replica_instance_class
    disk_autoresize = var.disk_autoresize

    user_labels = {
      is_production               = var.is_production
      tribe                       = var.tribe
      responsible_people          = var.responsible_people
      communication_slack_channel = var.communication_slack_channel
      alert_slack_channel         = var.alert_slack_channel
      repository                  = var.repository
    }

    #-------------------------------------------------#
    #   INSTANCE SPECIFICATION / NETWORK & SECURITY   #
    #-------------------------------------------------#
    ip_configuration {
      private_network = var.private_network
      ipv4_enabled    = "true"

      dynamic "authorized_networks" {
        for_each = [for item in var.sg_default_allowed_ips: item]
        content {
          name  = lookup(authorized_networks.value, "name", null)
          value = lookup(authorized_networks.value, "value", null)
        }
      }
      dynamic "authorized_networks" {
        for_each = [for item in var.sg_custom_allowed_ips: item]
        content {
          name  = lookup(authorized_networks.value, "name", null)
          value = lookup(authorized_networks.value, "value", null)
        }
      }
    }

    #-----------------------------------------#
    #   INSTANCE SPECIFICATION / PARAMETERS   #
    #-----------------------------------------#

    database_flags {
      name  = "max_connections"
      value = var.map_max_connections[var.instance_class]
    }
    database_flags {
      name  = "work_mem"
      value = var.map_work_mem[var.instance_class]
    }
    database_flags {
      name  = "vacuum_cost_limit"
      value = var.parameter_vacuum_cost_limit
    }
    database_flags {
      name  = "checkpoint_timeout"
      value = var.parameter_checkpoint_timeout
    }
    database_flags {
      name  = "max_wal_size"
      value = var.parameter_max_wal_size
    }
    database_flags {
      name  = "max_standby_streaming_delay"
      value = var.parameter_max_standby_streaming_delay
    }
    database_flags {
      name  = "random_page_cost"
      value = var.parameter_random_page_cost
    }
    database_flags {
      name  = "track_io_timing"
      value = var.parameter_track_io_timing
    }
    database_flags {
      name  = "track_activity_query_size"
      value = var.parameter_track_activity_query_size
    }
    database_flags {
      name  = "log_autovacuum_min_duration"
      value = var.parameter_log_autovacuum_min_duration
    }
    database_flags {
      name  = "autovacuum_vacuum_threshold"
      value = var.parameter_autovacuum_vacuum_threshold
    }
    database_flags {
      name  = "autovacuum_analyze_threshold"
      value = var.parameter_autovacuum_analyze_threshold
    }
    database_flags {
      name  = "autovacuum_vacuum_scale_factor"
      value = var.parameter_autovacuum_vacuum_scale_factor
    }
    database_flags {
      name  = "pg_stat_statements.track"
      value = var.parameter_pg_stat_statements_track
    }
  }
}

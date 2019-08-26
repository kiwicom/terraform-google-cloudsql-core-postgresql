#-------------------------------#
#   ENVIRONMENT SPECIFICATION   #
#-------------------------------#

variable "instance_name_without_version" {
}

variable "region" {
}

variable "is_production" {
}

variable "map_env" {
  type        = map(string)
  description = "is_production -> db label text"

  default = {
    "1" = "prod"
    "0" = "non-prod"
  }
}

variable "read_replica" {
}

variable "high_available" {
}

variable "map_availability_type" {
  type        = map(string)
  description = "high_available -> availability_type"

  default = {
    "0" = "ZONAL"
    "1" = "REGIONAL"
  }
}

variable "tribe" {
}

variable "responsible_people" {
}

variable "communication_slack_channel" {
}

variable "alert_slack_channel" {
}

variable "repository" {
}

#----------------------------#
#   INSTANCE SPECIFICATION   #
#----------------------------#

variable "map_major_version" {
  type        = map(string)
  description = "engine_name -> major_version_number"

  default = {
    #     # PostgreSQL
    "POSTGRES_11" = "11"
  }
}

variable "engine_version" {
}

variable "instance_class" {
}

variable "read_replica_instance_class" {
}

variable "allocated_storage" {
}

variable "disk_autoresize" {
}

#---------------------------------------------------#
#   INSTANCE SPECIFICATION / MASTER USER SETTINGS   #
#---------------------------------------------------#

variable "master_username" {
}

variable "master_password" {
}

#-------------------------------------------------#
#   INSTANCE SPECIFICATION / NETWORK & SECURITY   #
#-------------------------------------------------#
variable "private_network" {
}

variable "sg_default_allowed_ips" {
  type        = list(map(string))
  description = "List of default whitelisted IPs"
}

variable "sg_custom_allowed_ips" {
  type        = list(map(string))
  description = "List of custom whitelisted IPs"
}

#------------------------------------------------#
#   INSTANCE SPECIFICATION / DATABASE OPTIONS    #
#------------------------------------------------#

variable "db_name" {
}

#-------------------------------------#
#   INSTANCE SPECIFICATION / BACKUP   #
#-------------------------------------#

variable "backup_time" {
}

#-----------------------------------------#
#   INSTANCE SPECIFICATION / MONITORING   #
#-----------------------------------------#

#------------------------------------------#
#   INSTANCE SPECIFICATION / MAINTENANCE   #
#------------------------------------------#

variable "maintenance_window_day" {
}

variable "maintenance_window_hour" {
}

variable "maintenance_update_track" {
}

#-------------------------------------------------#
#   PARAMETERS / CONNECTIONS AND AUTHENTICATION   #
#-------------------------------------------------#

variable "map_max_connections" {
  type        = map(string)
  description = "Instance class -> max_connections"

  default = {
    # Shared-core machines (fixed)
    "db-f1-micro" = "100"
    "db-g1-small" = "200"

    # Custom machines (1 GB RAM -> 100 connections)
    "db-custom-1-3840" = "384"
  }
}

#----------------------------------------------#
#   PARAMETERS / RESOURCE USAGE (EXCEPT WAL)   #
#----------------------------------------------#

variable "map_work_mem" {
  type        = map(string)
  description = "Instance class -> work_mem (KB)"

  default = {
    # Shared-core machines (1% of RAM)
    "db-f1-micro"      = "629146"
    "db-g1-small"      = "1782579"
    # Custom machines (1% of RAM)
    "db-custom-1-3840" = "3932160"
  }
}

variable "parameter_vacuum_cost_limit" {
  default = "2000"
}

#----------------------------------#
#   PARAMETERS / WRITE AHEAD LOG   #
#----------------------------------#

variable "parameter_checkpoint_timeout" {
  default = "300"
  # 5 minutes
}

variable "parameter_max_wal_size" {
  default = "192"
  # 2 GB
}

#------------------------------#
#   PARAMETERS / REPLICATION   #
#------------------------------#

variable "parameter_max_standby_streaming_delay" {
  default = "3000"
  # 30 s
}

#-------------------------------#
#   PARAMETERS / QUERY TUNING   #
#-------------------------------#

variable "parameter_random_page_cost" {
  default = "1.1"
}

#-------------------------------------#
#   PARAMETERS / RUNTIME STATISTICS   #
#-------------------------------------#

variable "parameter_track_io_timing" {
  default = "off"
}

variable "parameter_track_activity_query_size" {
  default = "2048"
}

#-----------------------------#
#   PARAMETERS / AUTOVACUUM   #
#-----------------------------#

variable "parameter_log_autovacuum_min_duration" {
  default = "0"
}

variable "parameter_autovacuum_vacuum_threshold" {
  default = "100"
}

variable "parameter_autovacuum_analyze_threshold" {
  default = "100"
}

variable "parameter_autovacuum_vacuum_scale_factor" {
  default = "0.05"
}

#-------------------------#
#   PARAMETERS / CUSTOM   #
#-------------------------#

variable "parameter_pg_stat_statements_track" {
  default = "all"
}

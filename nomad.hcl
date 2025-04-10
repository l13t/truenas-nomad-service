data_dir = "/var/lib/nomad"
bind_addr = "0.0.0.0"
datacenter = "dc1"
disable_update_check = true

server {
  enabled = true
  bootstrap_expect = 3

  default_scheduler_config {
    scheduler_algorithm = "spread"

    memory_oversubscription_enabled = true

    # reject_job_registration = false

    preemption_config {
      batch_scheduler_enabled    = true
      system_scheduler_enabled   = true
      service_scheduler_enabled  = true
      sysbatch_scheduler_enabled = true # New in Nomad 1.2
    }
  }
}

client {
  enabled = true
  options {
    "docker.volumes.enabled" = "true"
  }
  node_class = "main"
  meta {
    "arch" = "amd64"
    "machine" = "truenas"
  }
}

plugin "docker" {
  config {
    endpoint = "unix:///var/run/docker.sock"

    extra_labels = ["job_name", "job_id", "task_group_name", "task_name", "namespace", "node_name", "node_id"]

    gc {
      image       = true
      image_delay = "3m"
      container   = true

      dangling_containers {
        enabled        = true
        dry_run        = false
        period         = "5m"
        creation_grace = "5m"
      }
    }

    volumes {
      enabled      = true
      selinuxlabel = "z"
    }

    allow_privileged = true
    allow_caps       = ["audit_write", "chown", "dac_override", "fowner", "fsetid", "kill", "mknod", "net_bind_service", "setfcap", "setgid", "setpcap", "setuid", "sys_chroot", "net_raw", "ep"]

  }
}


telemetry {
  publish_allocation_metrics = true
  publish_node_metrics       = true
  prometheus_metrics         = true
}

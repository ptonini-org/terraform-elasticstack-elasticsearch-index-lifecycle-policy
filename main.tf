resource "elasticstack_elasticsearch_index_lifecycle" "this" {
  name     = var.name

  dynamic "hot" {
    for_each = var.hot[*]
    content {
      min_age = hot.value.min_age

      dynamic "rollover" {
        for_each = hot.value.rollover[*]
        content {
          max_age                = rollover.value.max_age
          max_docs               = rollover.value.max_docs
          max_primary_shard_size = rollover.value.max_primary_shard_size
          max_size               = rollover.value.max_size
          min_age                = rollover.value.min_age
          min_docs               = rollover.value.min_docs
          min_primary_shard_docs = rollover.value.min_primary_shard_docs
          min_primary_shard_size = rollover.value.min_primary_shard_size
          min_size               = rollover.value.min_size
        }
      }

      dynamic "set_priority" {
        for_each = hot.value.set_priority[*]
        content {
          priority = set_priority.value
        }
      }

      dynamic "readonly" {
        for_each = hot.value.readonly[*]
        content {
          enabled = readonly.value
        }
      }
    }
  }

  dynamic "warm" {
    for_each = var.warm[*]
    content {
      min_age = warm.value.min_age

      dynamic "allocate" {
        for_each = warm.value.allocate
        content {
          exclude               = allocate.value.exclude
          include               = allocate.value.include
          require               = allocate.value.require
          number_of_replicas    = allocate.value.number_of_replicas
          total_shards_per_node = allocate.value.total_shards_per_node
        }
      }

      dynamic "migrate" {
        for_each = warm.value.migrate[*]
        content {
          enabled = migrate.value
        }
      }

      dynamic "set_priority" {
        for_each = warm.value.set_priority[*]
        content {
          priority = set_priority.value
        }
      }

      dynamic "readonly" {
        for_each = warm.value.readonly[*]
        content {
          enabled = readonly.value
        }
      }
    }
  }

  dynamic "cold" {
    for_each = var.cold[*]
    content {
      min_age = cold.value.min_age

      dynamic "allocate" {
        for_each = cold.value.allocate
        content {
          exclude               = allocate.value.exclude
          include               = allocate.value.include
          require               = allocate.value.require
          number_of_replicas    = allocate.value.number_of_replicas
          total_shards_per_node = allocate.value.total_shards_per_node
        }
      }

      dynamic "freeze" {
        for_each = cold.value.freeze[*]
        content {
          enabled = freeze.value
        }
      }

      dynamic "migrate" {
        for_each = cold.value.migrate[*]
        content {
          enabled = migrate.value
        }
      }

      dynamic "set_priority" {
        for_each = cold.value.set_priority[*]
        content {
          priority = set_priority.value
        }
      }

      dynamic "readonly" {
        for_each = cold.value.readonly[*]
        content {
          enabled = readonly.value
        }
      }
    }
  }

  dynamic "frozen" {
    for_each = var.frozen[*]
    content {
      min_age = frozen.value.min_age
    }
  }

  dynamic "delete" {
    for_each = var.delete[*]
    content {
      min_age = delete.value.min_age

      dynamic "wait_for_snapshot" {
        for_each = delete.value.wait_for_snapshot[*]
        content {
          policy = wait_for_snapshot.value
        }
      }
    }
  }
}
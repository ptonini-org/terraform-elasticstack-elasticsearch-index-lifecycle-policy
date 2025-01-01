variable "name" {}

variable "hot" {
  type = object({
    min_age = optional(string, "1h")
    rollover = optional(object({
      max_age                = optional(string)
      max_docs               = optional(number)
      max_primary_shard_size = optional(string)
      max_size               = optional(string)
      min_age                = optional(string)
      min_docs               = optional(number)
      min_primary_shard_docs = optional(number)
      min_primary_shard_size = optional(string)
      min_size               = optional(string)
    }))
    set_priority = optional(number)
    readonly     = optional(bool)
  })
}

variable "warm" {
  type = object({
    min_age = optional(string)
    allocate = optional(object({
      exclude               = optional(string)
      include               = optional(string)
      require               = optional(string)
      number_of_replicas    = optional(number)
      total_shards_per_node = optional(number)
    }))
    set_priority = optional(number)
    migrate      = optional(bool, true)
    readonly     = optional(bool, true)
  })
  default  = null
}

variable "cold" {
  type = object({
    min_age = optional(string)
    allocate = optional(object({
      exclude               = optional(string)
      include               = optional(string)
      require               = optional(string)
      number_of_replicas    = optional(number)
      total_shards_per_node = optional(number)
    }))
    set_priority = optional(number)
    freeze       = optional(bool)
    migrate      = optional(bool, true)
    readonly     = optional(bool, true)
  })
  default  = null
}

variable "frozen" {
  type = object({
    min_age = optional(string)
  })
  default  = null
}

variable "delete" {
  type = object({
    min_age           = optional(string)
    wait_for_snapshot = optional(string)
  })
  default  = null
}
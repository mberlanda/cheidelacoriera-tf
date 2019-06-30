variable "aws_region" {
  default = "eu-west-1"
}

provider "aws" {
  version = "~> 2.0"
  region  = "${var.aws_region}"
}

# Redis cluster
# micro 158 € per year, small 316 €
resource "aws_elasticache_cluster" "cheidelacoriera_redis" {
  cluster_id           = "cheidel-cache"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis4.0"
  engine_version       = "4.0.10"
  port                 = 6379
}

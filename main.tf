variable "aws_region" {
  default = "eu-west-1"
}

variable "db_password" {
  default = "foobarbaz"
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

# PG database
# https://aws.amazon.com/rds/free/
# micro 175.2 € per year, small 341.64 €
resource "aws_db_instance" "cheidelacoriera_db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgresql"
  engine_version       = "9.6"
  instance_class       = "db.t2.micro"
  name                 = "cheidelacoriera_production"
  username             = "cheidelacoriera"
  password             = "${var.db_password}"
  parameter_group_name = "default.postgresql9.6"
}

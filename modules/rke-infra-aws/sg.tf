# Create aws sg
resource "aws_security_group" "master_nodes" {
  name   = "${var.prefix}-master-nodes"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = ""
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = ""
  }
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = ""
  }
ingress {
    from_port       = 2376
    to_port         = 2380
    protocol        = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = ""
  }
  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = ""
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
    description = ""
  }
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["10.0.0.0/16"]
    description = ""
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = ""
  }
  tags = local.tags
}
# Create aws sg
resource "aws_security_group" "svc_nodes" {
  name   = "${var.prefix}-svc-nodes"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = ""
  }
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = ""
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = ""
  }

  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = ""
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
    description = ""
  }
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["10.0.0.0/16"]
    description = ""
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = ""
  }
  tags = local.tags
}
# Create aws sg
resource "aws_security_group" "game_nodes" {
  name   = "${var.prefix}-game-nodes"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = ""
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = ""
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = ""
  }

  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = ""
  }
  ingress {
    from_port       = 7000
    to_port         = 8000
    protocol        = "UDP"
    cidr_blocks = ["0.0.0.0/0"]
    description = ""
  }
  ingress {
    from_port       = 50000
    to_port         = 50000
    protocol        = "UDP"
    cidr_blocks = ["0.0.0.0/0"]
    description = ""
  }
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
    description = ""
  }
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["10.0.0.0/16"]
    description = ""
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = ""
  }
  tags = local.tags
}
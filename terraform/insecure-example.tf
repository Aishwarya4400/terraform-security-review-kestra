resource "aws_s3_bucket" "example" {
  bucket = "my-demo-public-bucket-aish-123"
}

resource "aws_security_group" "web" {
  name = "web-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
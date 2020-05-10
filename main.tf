provider "aws" {
  region = "eu-central-1"
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC9ocH2ScV6cp9ElBkkqTwzEgnf2O5e70QRJFNvPyBOKw5NGkuJC+jn81OPdDrvjQ+q+m8uET6DjqbvX3rDILZDh81Nm1++26aNJ8+OpAeOQ58FSZLbrViOfpD9FxnL1kjsoQ/D5SmQb7s3RzcNvud1vR0Jb7dWAV5+JwyU/NID67jppmE2kJ9VhyhORgLYr0+JYTY8ApurQdM2rz/rLfLgKEVw+uuL+WVgZ8lIrkZR+xw8EaLBjJpsjPLhqGAtgtuHAI9czmHDKrUZW/ngoQt+//J6x9zSSsUZjNzsMs6HVC+i2Cc5HT5+6yTaEmT+r8lqyrlUolng5dnPxoXd1ffuSSiCyiAZchq36Po16T2Zij+X3QmjeYgPA1fSM0fSSqGXuxYRF5zygAg+QK5Cy1aSgJM5KFAU1TBkky6WrR4VVKWpRr+jL5m1OS68MgZjTy5mt+nNPOnvRwPWHqdxx+FtZuCFSXQSXtfiSPZShf8g2iJnXbVSxmYhDUxTL1eHQ7s= aramadan@AhmedRamadan"
}


data "aws_ami" "centos" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ami-centos7-1805-01"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["971291234853"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.centos.id
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.deployer.key_name}"
  user_data     = filebase64("./script.sh")
}

resource "aws_eip" "publicip" {
  instance = aws_instance.web.id
  vpc      = true  
}

resource "aws_security_group_rule" "inboud_web_traffic" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks        = ["0.0.0.0/0"]
  security_group_id = data.aws_security_group.default.id
}

data "aws_security_group" "default" {
  filter {
    name   = "group-name"
    values = ["default"]
  }
}




output "ip"{
  value = "http://${aws_eip.publicip.public_ip}"

}
output "dns" {
  value = aws_eip.publicip.public_dns
}
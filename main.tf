resource "aws_key_pair" "bitrix" {
    key_name = "bitrix"
    public_key = "${var.public_key}"

}

resource "aws_security_group" "bitrix" {
  name        = "bitrix_security_group"
  description = "Bitrix security group"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "bitrix" {
  ami             = "${data.aws_ami.centos.id}"
  instance_type   = "t2.micro"
  associate_public_ip_address = true
  key_name = "${aws_key_pair.bitrix.id}"
  vpc_security_group_ids = ["${aws_security_group.bitrix.id}"]
  tags {
    Name = "bitrix"
  }
}

resource "aws_eip" "bitrix_ip" {
  instance = "${aws_instance.bitrix.id}"
  vpc      = true

  provisioner "local-exec" {
    command = "ansible-playbook -i '${aws_eip.bitrix_ip.public_ip},' main.yml --user=centos --private-key=${var.private_key_path}"
  }
}

output "ip" {
  value = "${aws_eip.bitrix_ip.public_ip}"
}



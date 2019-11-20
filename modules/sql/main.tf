# Récupération des données d'un serveur web existant
data "aws_ami" "sql_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["multicloud-aws-web-*"]
  }

  owners = ["640680520898"]
}

# Création de l'instance du serveur web
resource "aws_instance" "sql1_instance" {
  ami           = "${data.aws_ami.sql_ami.id}"
  instance_type = "t2.micro"
  key_name      = "${var.ssh_key_name}"

  network_interface {
    device_index         = 0
    network_interface_id = "${aws_network_interface.sql1_net.id}"
  }

  tags = "${merge(map("Name", format("%s", var.name)), var.tags)}"
}

# Création de l'interface du serveur web
resource "aws_network_interface" "sql1_net" {
  subnet_id   = "${var.subnet1_id}"
  private_ips = ["${var.private_ip1}"]

  tags = {Name="SQL1-Interface"}
}

resource "aws_network_interface" "sql2_net" {
  subnet_id   ="${var.subnet2_id}"
  private_ips =["${var.private_ip2}"]
  
  tags = {Name="SQL2-Interface"}
}


resource "aws_instance" "sql2_instance" {
  ami           = "${data.aws_ami.sql_ami.id}"
  instance_type = "t2.micro"
  key_name      = "${var.ssh_key_name}"

  network_interface {
    device_index         = 0
    network_interface_id = "${aws_network_interface.sql2_net.id}"
  }

  tags = "${merge(map("Name", format("%s", var.name)), var.tags)}"
}
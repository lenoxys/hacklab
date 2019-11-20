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
    network_interface_id = "${aws_network_interface.sql1.id}"
  }

  tags = "${merge(map("Name", format("%s", var.name)), var.tags)}"
}

# Création de l'interface du serveur web
resource "aws_network_interface" "sql1" {
  subnet_id   = "${var.subnet_id1}"
  private_ips = ["${var.private_ip1}"]

  tags = {Name="SQL1-Interface"}
}

resource "aws_network_interface" "sql2" {
  subnet_id   ="${var.subnet_id2}"
  private_ips =["${var.private_ip2}"]
  
  tags = {Name="SQL2-Interface"}
}


resource "aws_instance" "sql2_instance" {
  ami           = "${data.aws_ami.sql_ami.id}"
  instance_type = "t2.micro"
  key_name      = "${var.ssh_key_name}"

  network_interface {
    device_index         = 0
    network_interface_id = "${aws_network_interface.sql2.id}"
  }

  tags = "${merge(map("Name", format("%s", var.name)), var.tags)}"
}
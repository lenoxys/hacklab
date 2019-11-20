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
resource "aws_instance" "sql" {
  ami           = "${data.aws_ami.sql_ami.id}"
  instance_type = "t2.micro"
  key_name      = "${var.ssh_key_name}"

  network_interface {
    device_index         = 0
    network_interface_id = "${aws_network_interface.web.id}"
  }

  tags = "${merge(map("Name", format("%s", var.name)), var.tags)}"
}

# Création de l'interface du serveur web
resource "aws_network_interface" "web" {
  subnet_id   = "${var.subnet_id}"
  private_ips = ["${var.private_ip}"]

  tags = {Name="web-Interface"}
}
provider "aws" { # Définition du provider
  region  = "${var.aws_region}" # Variable Région AWS
  version = "2.7"
}

resource "aws_vpn_connection" "main" {
  vpn_gateway_id      = "${aws_vpn_gateway.vpn_gw.id}"
  customer_gateway_id = "${aws_customer_gateway.main_cust_gw.id}"
  type                = "ipsec.1"
  static_routes_only  = true
}

resource "aws_customer_gateway" "main_cust_gw" {
  bgp_asn    = 65000
  ip_address = "${var.public_ip_fw1}"
  type       = "ipsec.1"

  tags = {
    Name = "main-customer-gateway"
  }
}

resource "aws_customer_gateway" "sec_cust_gw" {
  bgp_asn    = 65001
  ip_address = "${var.public_ip_fw2}"
  type       = "ipsec.1"

  tags = {
    Name = "main-customer-gateway"
  }
}

resource "aws_vpn_gateway" "vpn_gw" {
  vpc_id = "${var.vpc_client_id}"

  tags = {
    Name = "vpn gw vpc_client"
  }
}
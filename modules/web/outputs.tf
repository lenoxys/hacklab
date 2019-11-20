output "sql_instance_id1" {
  value = "${aws_instance.sql1_instance.id}"
}
output "sql_instance_id2" {
  value = "${aws_instance.sql2_instance.id}"
}
output "web_instance_id2" {
  value = "${aws_instance.sql2.id}"
}
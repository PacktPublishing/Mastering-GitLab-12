
output "key_pem" {
  value = "${tls_private_key.mykey.private_key_pem}}"
  sensitive = true
}
output "key_name" {
  value = "${aws_key_pair.keypair.key_name}"
  sensitive = false
}



resource "tls_private_key" "privkey"
{
    algorithm = "RSA" 
    rsa_bits = 4096
}
resource "aws_key_pair" "keypair"
{
    key_name = "${var.key_name}"
    public_key = "${tls_private_key.privkey.public_key_openssh}"
}
output "private_key" {
  value = "${tls_private_key.privkey.private_key_pem}"
  sensitive = true
}
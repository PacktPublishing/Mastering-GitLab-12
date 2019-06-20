variable "ssh_private_key_primary" {
    description = "Which SSH key to use for ansible"
    default = "/tmp/mykey1.pem"
} 
variable "ssh_private_key_secondary" {
    description = "Which SSH key to use for ansible"
    default = "/tmp/mykey2.pem"
} 
variable "python_interpreter" {
    description = "Which Python version to use for ansible"
    default = "/usr/bin/python3"
}

variable "sshuser" {
   description = "Which OS user to use for ansible"
   default = "ubuntu"
}
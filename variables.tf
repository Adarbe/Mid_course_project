variable "AWS_ACCESS_KEY_ID" {}
variable "AWS_SECRET_ACCESS_KEY" {}

variable "mid_project_id" {
    default= []
}
output "public_ip_jenkins_master"  {
value = "${aws_instance.jenkins_master.public_ip}"
}
variable "jenkins_master_port" {
  description = "The Port of the master jenkins instance"
  default = 8080
}
variable "aws_key_pair" {
  description = "The name of an EC2 Key Pair that can be used to SSH to the EC2 Instances in this cluster. Set to an empty string to not associate a Key Pair."
  default     = "jenkins_ec2_key"
}

# variable "ssh_key_path" {
#   description = "The path of an EC2 Key Pair that can be used to SSH to the EC2 Instances in this cluster. Used for provisioning."
#   default     = ""
# }


variable "plugins" {
  type        = "list"
  description = "A list of Jenkins plugins to install, use short names."
  default     = ["git", "xunit"]
}


variable "jnlp_port" {
  description = "The Port to use for Jenkins master to slave communication bewtween instances"
  default     = 49187
}
variable "AWS_ACCESS_KEY_ID" {}
variable "AWS_SECRET_ACCESS_KEY" {}

variable "mid_project_id" {
    default= []
}

variable "jenkins_master_port" {
  description = "The Port of the master jenkins instance"
  default = 8080
}

variable "plugins" {
  type        = "list"
  description = "A list of Jenkins plugins to install, use short names."
  default     = ["git", "pipeline", "SSH Slaves", "Build Monitor View","GreenBalls", "Blue Ocean", "Slack Notifications", "GitHub Plugin", "Kubernetes"]
}


variable "jnlp_port" {
  description = "The Port to use for Jenkins master to slave communication bewtween instances"
  default     = 49187
}
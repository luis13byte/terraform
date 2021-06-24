## Script directory

These scripts automate tasks and run as cloud-init during the deployment of Terraform instances.

It seems that the script gives problems with variables when running as cloud-init with Terraform, it is not able to create them during script execution, it only accepts the value specified from the template_file of the Terraform manifest. The idea is to make its value changeable for different CentOS OS deployments so instead of variables it has stored those values in simple files in the /tmp path.

# Setting up Bitrix environment.

## Requirments: ##
1) Account on AWS with ACCESS_KEY & SECRET_KEY (You can get those here: https://console.aws.amazon.com/iam/home?#security_credential).
2) Ansible 2.6+ (installation instructions: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
3) Terraform (installation instructions: https://www.terraform.io/intro/getting-started/install.html)
4) Source Bitrix site with admin access to dashboard. 

## Usage: ##
1) Clone the repository and copy `variables.tf.example` to `variables.tf`. Configure AWS credentials, public key, and a path to the private key. Change AWS region, if needed.
2) run command `terraform init && terraform apply`. Wait until script finished and save IP in output.
3) Go to the http://SOURCE-BITRIX-SITE.HERE/bitrix/admin/dump.php and make a backup. Choose the "Site folder" option. After that go to the http://SOURCE-BITRIX-SITE.HERE/bitrix/admin/dump_list.php and copy the link for the last backup.
4) Go to the http://IP_FROM_TERRAFORM and choose "Restore from backup" option. Enter the link from step 3 and follow instructions.

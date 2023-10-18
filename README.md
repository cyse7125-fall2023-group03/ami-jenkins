# ami-jenkins 

Group 3
## Steps to run Packer 
 - packer init .
 - packer validate .
 - packer build -var aws_access_key=$AWS_DEV_ACCESS_KEY -var aws_secret_key=$AWS_DEV_SECRET_KEY -var subnet_id=$AWS_DEV_SUBNET_ID -var aws_region=$AWS_REGION ami.pkr.hcl
 - The values are configured as secrets in the Organization. The AMI will be built and shared across all the owners given. Then we can use the ami-id to create the infrastructure.
## GitHub Actions
 - Added branch protection by preventing merge if any workflow fails. Added unit test cases to the workflow to make sure. AMI is built when a pull request is merged.

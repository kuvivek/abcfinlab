# abcfinlab
abcfinlab assignment

## Steps followed
1. Create an AWS Free account with your Credit Card credential.
 https://aws.amazon.com/free/?nc2=h_ql_pr_ft&all-free-tier.sort-by=item.additionalFields.SortRank&all-free-tier.sort-order=asc&awsf.Free%20Tier%20Types=*all&awsf.Free%20Tier%20Categories=*all
   a. Force AWS MFA policy
   
   AWS policy which forces MFA, created from the official docs: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_examples_aws_my-sec-creds-self-manage.html

   b. Create Groups called `Admins`, and then attach existing 'AWS Managed' - `AdministratorAccess` policy and the newly created 'Custom Policy' created via `enforcedMFA.json` file.

   c. Create an IAM user with both Access Types: `Programmatic Access` and `AWS Management Console Access`. It returns the 12 digits Account ID. Copy and save it. Useful for the next login using the newly created IAM user. Log out from Root user and login from the IAM user

   d. Login through 12 digit Account ID and the IAM user, first time it will not ask for MFA, as we have not associated the virtual MFA device to it.

   e. Associate the MFA device in the IAM -> User -> Select the IAM user -> Security Credentials Tab  -> Assigned MFA device (Manage option). Once done logout and login again. It will ask for MFA credentials.

   f. Create aws-vault based on the command mentioned in this link: https://github.com/99designs/aws-vault#installing
      `aws-vault exec vivek-iam-personal --duration=12h` - This command will save the session with the aws credentials for 12 hours.
      
2. Get AWS ready for Terraform
  Follow along the steps mentioned in this document.
  https://www.terraform.io/language/settings/backends/s3

  - Creation of private s3 bucket 'petclinic-terraformtfstate' for the tfstate storage with the versioning enabled. https://aws.amazon.com/s3/
    ```
    MacBook-Pro:abcfinlab vivek$ aws-vault exec vivek-iam-personal -- aws s3 ls
    Enter MFA code for arn:aws:iam::943618641173:mfa/vivek: 577529
    2022-05-26 13:32:10 petclinic-terraformtfstate
    MacBook-Pro:abcfinlab vivek$
    ```
  - DynamoDB table creation 'petclinic-terraformtfstate-lock' along with Partition key as 'LockID' for storing the lock of the tfstate in North Virginia (for cheaper cost, 1st AWS datacenter of AWS), so that only one instance of terraform is executed. https://aws.amazon.com/dynamodb/
    ```
    MacBook-Pro:~ vivek$ aws-vault exec vivek-iam-personal -- aws dynamodb list-tables
    {
        "TableNames": [
            "petclinic-terraformtfstate-lock"
        ]
    }

    MacBook-Pro:~ vivek$
    ```
  - ECR repository `spring-petclinic` with scan on push enabled in the North Virginia region (us-east-1) , for the Spring Boot Application docker image storage.

3. Configure terraform
  - Add .gitignore
  - Add main.tf file with the provider aws version as 4.15.1 as per the latest released version mentioned here.
  https://github.com/hashicorp/terraform-provider-aws/blob/main/CHANGELOG.md

4. Setup Docker-compose to run terraform - For standardizing the version and also minimalize the tools installation on local machine.

  MacBook-Pro:abcfinlab vivek$
  MacBook-Pro:abcfinlab vivek$ aws-vault exec vivek-iam-personal --duration=12h
  Enter MFA code for arn:aws:iam::943618641173:mfa/vivek: 632591
  bash: export: `%1~': not a valid identifier
  bash: export: `0': not a valid identifier
  
  The default interactive shell is now zsh.
  To update your account to use zsh, please run `chsh -s /bin/zsh`.
  For more details, please visit https://support.apple.com/kb/HT208050.
  bash-3.2$
  bash-3.2$ ls
  README.md		abcfinlabProject.txt	app			deploy			enforcedMFA.json
  bash-3.2$
  bash-3.2$ docker-compose -f deploy/docker-compose.yml run --rm terraform plan
  Creating deploy_terraform_run ... done
  Acquiring state lock. This may take a few moments...
  data.aws_route53_zone.zone: Reading...
  data.aws_region.current: Reading...
  data.aws_region.current: Read complete after 0s [id=us-east-1]
  data.aws_ami.amazon_linux: Reading...
  data.aws_ami.amazon_linux: Read complete after 0s [id=ami-06eecef118bbf9259]
  data.aws_route53_zone.zone: Read complete after 1s [id=Z05407483W43EYH5EEZ55]
  
  Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
    + create
  
  Terraform will perform the following actions:
  
    # aws_acm_certificate.cert will be created

  .... (Output truncated for brevity)


https://hub.docker.com/r/hashicorp/terraform-k8s/tags

https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started#install-terraform

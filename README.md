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

2. Get AWS ready for Terraform
  Follow along the steps mentioned in this document.
  https://www.terraform.io/language/settings/backends/s3

  - Creation of private s3 bucket 'petclinic-terraformtfstate' for the tfstate storage with the versioning enabled. https://aws.amazon.com/s3/
  - DynamoDB table creation 'petclinic-terraformtfstate-lock' along with Partition key as 'LockID' for storing the lock of the tfstate in North Virginia (for cheaper cost, 1st AWS datacenter of AWS), so that only one instance of terraform is executed. https://aws.amazon.com/dynamodb/
  - ECR repository `spring-petclinic` with scan on push enabled in the North Virginia region (us-east-1) , for the Spring Boot Application docker image storage.

3. Configure terraform
  - Add .gitignore
  - Add main.tf file with the provider aws version as 4.15.1 as per the latest released version mentioned here.
  https://github.com/hashicorp/terraform-provider-aws/blob/main/CHANGELOG.md


https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started#install-terraform

https://www.whizlabs.com/blog/terraform-certification-exam-questions/

Q 1. One of your colleagues is new to Terraform and wants to add a new workspace named new-hire. What command he should execute from the following?
A. terraform workspace –new –new-hire
B. terraform workspace new new-hire
C. terraform workspace init new-hire
D. terraform workspace new-hire

B - Y 


Q 2. John is a newbie to Terraform and wants to enable detailed logging to find all the details
Which environment variable does he need to set?
A. TF_help
B. TF_LOG
C. TF_Debug
D. TF_var_log

B - Y


Q 3. Which option will you use to run provisioners that are not associated with any resources?
A. Local-exec
B. Null_resource
C. Salt-masterless
D. Remote-exec

B - Y 


Q 4. Which language does terraform support from the below list?
A. XML
B. Javascript
C. Hashicorp Language & JSON
D. Plaintext

C - Y


Q 5. What is the provider version of Google Cloud being used in Terraform?
Google = “~> 1.9.0”
A. 1.9.1
B. 1.0.0
C. 1.8.0
D. 1.9.2

D - X  AND A


Q 6. On executing terraform plan, terraform scans the code and appends any missing argument before terraform apply.
A. True
B. False

B - Y 



Q 7. Do terraform workspaces help in adding/allowing multiple state files for a single configuration?
A. True
B. False

A - Y

Q 8. Does terraform standard backend type support remote management system?
A. True
B. False

A - X - enhanced support remote runs, standard does not


Q 9. Does terraform refresh command updates the state files?
A. True
B. False

A - guess - Y 


Q 10. Which command is used to launch terraform console?
A. terraform apply -config
B. terraform console
C. terrafrom plan
D. terrafrom consul

B - Y


Q 11. Which of the following below helps users to deploy policy as a code?
A. Resources
B. Functions
C. Sentinel
D. Workspaces

C - Y


Q 12. You have been asked to stop using static values and make code more dynamic. How can you achieve it? Select the correct option from below.
A. Local values
B. Input variables
C. Depends_on
D. Functions

B - Y


Q 13. Which of the following flags can be used with terraform apply command?
A. Auto-approve
B. Init
C. Get
D. Console

A - Y


Q 14. What is the default number of concurrent operations supported by terraform apply command?
A. 100
B. 10
C. 5
D. 1

D - guess - N - its 10! 


Q 15. You are trying to login into Terraform Enterprise. Which of the following command is used to save the API token?
A. terraform get
B. terraform API-get
C. terraform login
D. terraform cloud – get api

C - Y


Q 16. What are the two supported backend types in Terraform?
A. Remote-backend
B. Enhanced
C. Local- backend
D. Standard

A, C - X WRONG, enhanced and standard


Q 17. Is terraform state-unlock command used to unlock the locked state file?
A. True
B. False

A - guess X - terraform force-unlock 


Q 18. SMB(Server Message Block) and RDP(Remote Desktop) are supported connection types in the remote-exec provisioner. True or False?
A. True
B. False

A - guess X - SSH and WINRM


Q 19. Community providers are downloaded automatically using terraform init command. True or False?
A. True
B. False

A - Y


Q 20. By using the count meta-argument, you can scale the resources by incrementing the number.
A. True
B. False

A - Y 


Q 21. A user wants to list all resources which are deployed using Terraform. How can this be done?
A. terraform state show
B. terraform state list
C. terraform show
D. terraform show list

B - Y


Q 22. Which among the following log command should be set to get Maximum verbosity of terraform logs?
A. set the TF_LOG=DEBUG in environment variable
B. set the TF_LOG=INFO in environment variable
C. set the TF_LOG=TRACE in environment variable
D. set the TF_LOG=WARN in environment variable

C - Y



Q 23. Which among the following are not module source options?
A. Local Path
B. Terraform registry
C. Bit bucket
D. HTTP URLs
E. BLOB storage

D - guess - X E


Q 24. Which of the following command can be used to syntactically check to terraform configuration before using apply or plan command?
A. terraform fmt
B. terraform validate
C. terraform show
D. terraform check

B - Y

Q 25. When multiple team members are working on the same state file, the state file gets locked. How to remove the lock?
A. terraform force-unlock LOCK_ID
B. terraform force-unlock STATE_FILE
C. terraform unlock LOCK_ID
D. terraform force-unlock=true

A - Y

Q26 : If you want to replace a particular object even though there are no configuration changes in the code, which command from below would be best suited.
A. terraform destroy
B. terraform taint
C. terraform replace
D. terraform state rm

C - Y


Domain : Use the Terraform CLI (outside of core workflow)
Q27 : The data directory in terraform is used to retain data that must persist from one command to the next, so it’s important to have this variable set consistently throughout all the Terraform workflow commands (starting with terraform init) or else Terraform may be unable to find providers, modules, and other artifacts. Which ENVIRONMENT VARIABLE is used from below to ‘set’ per-working-directory data?
A. TF_DATA_DIR
B. TF_WORKSPACE
C. TF_DATA
D. TF_DATA_WORKSPACE

A - guess - Y


Domain : Understand Terraform Cloud and Enterprise capabilities
Q28 : Which of the following commands can be used to logout from terraform cloud?
A. Terraform logout
B. Terraform –logout
C. Terraform log out
D. Terraform –log-out

A - Y


Q29 : Debug is the most verbose log level in Terraform.
A. True
B. False

B - Y


Domain : Understand Terraform’s purpose (vs other IaC)
Q30 : What is a multicloud deployment?
A. The possibility to run a simple .tf into multiple cloud using a single provider to deploy into multiple cloud providers
B. The possibility to run your Terraform code using multiple cloud providers to deploy your infrastructure into multiple cloud providers
C. The possibility to run your Terraform code using a single-global provider to deploy your infrastructure into multiple cloud providers
D. The possibility to run your Terraform code by other tools such as Amazon Cloudformation


B - Y


Domain : Understand Terraform basics
Q31 : You have the following provider configuration for AWS:
provider “aws” {
  region = “eu-west-1”
}
provider “aws” {
  alias  = “frankfurt”
  region = “eu-central-1”
}
How do you specify an instance creation on eu-central-1 ?
A. resource “aws_instance” “whizlabs” {   provider = aws.central   … }
B. resource “aws_instance” “whizlabs” {   provider = aws.frankfurt   … }
C. resource “aws_instance” “whizlabs” {   … }
D. resource “aws_instance” “whizlabs” {   provider = aws.west … }

B - Y



Domain : Interact with Terraform modules
Q32 : What of the following is not a source type for a module?
A. SSH
B. Github
C. Bitbucket
D. S3

A - Y


Domain : Interact with Terraform modules
Q33 : How do you download a module configured in your Terraform code?
module “ecs_cluster”  {
source  = “terraform-aws-modules/ecs/aws”
version = “2.8.0”
// inputs
}
A. terraform get module ecs_cluster
B. terraform install modules ecs_cluster
C. terraform init
D. terraform module init

C - Y 


Q34 : You are a DevOps Engineer working in a CI/CD Pipeline using Jenkins. You have three stages identified: Init, Plan and Apply. After your terraform plan, you need to apply your infrastructure. In your pipeline script basically you wrote: “terraform apply”.
After triggering the pipeline you see that there was no progress and the Apply stage is waiting to confirm the changes. How can you automatically apply the changes when you type “terraform apply” ?
A. terraform apply -auto-approve
B. terraform apply -yes
C. terraform apply  | echo “yes”
D. terraform apply | yes

A - Y


Domain : Implement and maintain state
Q35 : What is the name of the workspace when you execute “terraform init”?
A. New
B. No workspace is created
C. Workspace
D. Default

D - Y



Domain : Implement and maintain state
Q36 : How can you delete the default workspace?
A. terraform workspace delete default
B. terraform delete workspace default
C. terraform workspace -rm default
D. None of the options are correct

D? - thought you cant? - Y 


Domain : Read, generate, and modify configuration
Q37 : You are a Senior DevOps Engineer and you want to provision your infrastructure Terraform code in different environments having your Terraform configuration DRY. What is the best way to do it? You also want to minimize the number of changes in your code (Choose the best answer regarding best practices in Terraform and DevOps)
A. Have a different var files per environment and apply those files to your Terraform Configuration
B. Have different branches in your Git repository with different var files
C. Move out from Terraform and use Terragrunt

A - Y



Domain : Read, generate, and modify configuration
Q38 : How can you view the value of a particular output using the CLI? The output you want to query was declared like
output “ips” {
  value = aws_instance.frontend.*.public_ip
}
A. terraform output show
B. terraform output show ips
C. terraform output
D. terraform output ips

D - Y



Domain : Understand Terraform Cloud and Enterprise capabilities
Q39 : You are working with different Terraform States and you need access to the Terraform state for the organization “whizlabs” and the workspace “prod”. How will you configure the Terraform Datasource?
A. data “terraform_remote_state” “remote_state” {   backend = “remote”   config = { organization = “whizlabs” workspaces = {   name = “prod” }   } }
B. data “terraform_remote_state” “remote_state” {   backend = “remote”   organization = “whizlabs”   workspaces = “prod”   } }
C. data “terraform_remote_state” “remote_state” {   backend = “remote”   organization = “whizlabs.prod”   } }
D. None of the above

B - guess - X - need to set in config block fro remot e state

Domain : Understand infrastructure as code (IaC) concepts
Q40 : What benefits can provide the Infrastructure as Code for organizations?
A. IaC can be used to deploy the latest features of Cloud Services
B. Share and reusability of the code
C. Blueprint of the DataCenter
D. Versioning

B - guess (and A?) - X - B, C, D 


Domain : Understand Terraform’s purpose (vs other IaC)
Q41 : State is a necessary requirement for Terraform to function. What of the following is not a purpose of Terraform State?
A. Mapping to the real world
B. Performance
C. Syncing
D. Security

A - X, D 


Domain : Use the Terraform CLI (outside of core workflow)
Q42 : You want to test the “split” function of Terraform locally to verify the output that the split function will be returned. What is the best approach to test this function locally?
A. echo ‘split(“,”, “foo,bar,baz”)’ | terraform console
B. echo ‘split(“,”, “foo,bar,baz”)’ | terraform plan
C. echo ‘split(“,”, “foo,bar,baz”)’ | terraform apply
D. None of above


A - Y 

Domain : Interact with Terraform modules
Q43 : In Terraform, What are modules used for?
A. Re-use configuration
B. Ensure best practices
C. Encapsulate configuration
D. All of the above

D - Y 


Domain : Interact with Terraform modules
Q44 : Which of the following extensions is recognized by Terraform to fetch a module using an URL endpoint.
A. Zip
B. Tar.gz
C. Tar.xz
D. All of the above

D - guess - Y


Domain : Implement and maintain state
Q45 : What happens if the locking state fails when executing an operation in Terraform?
A. Terraform will continuously apply its configuration without modifying the state, then you can execute a Terraform refresh to update the state
B. Terraform will continuously apply its configuration and apply changes into the state
C. Terraform will not continue to plan/apply any changes
D. Terraform will continuous and will force lock the state and will refresh the state

C - guess - Y 


Q46 : You want to assign the default value “No description set up” to a variable in your Terraform code just if a value has not been assigned on the variables.tf. If this value has content, you can assign the value to the variable. How can you perform this in your Terraform code?
A. description = var.description == “null” ? “No description set up” : var.description
B. description = if var.description == “null” then “No description set up” else var.description
C. description = if (var.description == “null”) then { “No description set up” } else { var.description }
D. description = var.description == “null” : “No description set up” ? var.description

A - Y

Domain : Understand Terraform basics
Q47 : How do you force users to use a particular version of required providers in your terraform code?
A. terraform { required_providers { aws = { source = “hashicorp/aws” version =”3.74.1″  } } }
B. terraform {     aws = {       source = “hashicorp/aws”       version ~> “3.74.1”     } }
C. aws = {       source = “hashicorp/aws”       version = “3.74.1”     }   }
D. provider “aws” = {       source = “hashicorp/aws”       version = “3.74.1” }

A - Y 


Domain : Understand Terraform basics
Q48 : What of the following next arguments are not part of the generic meta-arguments for a provider?
A. Alias
B. Version
C. Profile
D. Region

A - X - C And D


Domain : Understand Terraform basics
Q49 : local-exec invokes a process on the resource that is being created by Terraform.
A. True
B. False

B - Y


Domain : Understand infrastructure as code (IaC) concepts
Q50 : What are the main advantages to use Terraform as the IaC tool?
A. Manage infrastructure on multiple cloud providers
B. Versioning
C. Status of your infrastructure based on a State to track all the resources and components
D. All of above

D - Y 


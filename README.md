# ec2_instances_creation_using_terraform



This sample code is used to provision a new ec2 instance on the aws cloud, this code is declarative and can be maintained in a version control system allowing it to be distributed to other teams.


The code is declarative, but what does declarative mean; The code we defined is the state that we want our infrastructure to be in that's the desired state.

Terraform will take care of what is required to go from the current state to the desired state without us having to worry about how to get there, So how does terraform do that.

- Terraform works in three phases init, plan and apply.
	- During the **init** phase terraform initializes the project and identifies the providers to be used for the target environment.
	- During the **plan** phase terraform drafts a plan to get to the target state.
	- And then in the **apply** phase terraform makes the necessary changes required on the target environment to bring it to the desired state.


**Terraform Workflow :-**

A simple terraform workflow consists of 4 steps :
1) write the configuration file
2) run the terraform init command
3) review the execution plan using the terraform plan command
4) Once we are ready, apply the changes using the terraform apply command.



**Environment Variables**
Credentials can be provided by using the AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, and optionally AWS_SESSION_TOKEN environment variables. The region can be set using the AWS_REGION or AWS_DEFAULT_REGION environment variables.

**For example:**
provider "aws" {}

	- $ export AWS_ACCESS_KEY_ID="anaccesskey"
	- $ export AWS_SECRET_ACCESS_KEY="asecretkey"
	- $ export AWS_REGION="us-west-2"
	- $ terraform plan

Other environment variables related to authorization are:
	- AWS_PROFILE
	- AWS_CONFIG_FILE
	- AWS_SHARED_CREDENTIALS_FILE




**Write configuration**
	- The set of files used to describe infrastructure in Terraform is known as a Terraform configuration. You will write your first configuration to define a single AWS EC2 instance.

**Initialize the directory**
	- When you create a new configuration — or check out an existing configuration from version control — you need to initialize the directory with **terraform init**.
	- Initializing a configuration directory downloads and installs the providers defined in the configuration, which in this case is the aws provider.

**Format and validate the configuration**
	- It is recommended to use consistent formatting in all of your configuration files. The **terraform fmt** command automatically updates configurations in the current directory for readability and consistency.
	- Format your configuration. Terraform will print out the names of the files it modified, if any.
	- You can also make sure your configuration is syntactically valid and internally consistent by using the **terraform validate** command.
	- Validate your configuration. If the configuration provided is valid, then Terraform will return a success message.

**Create infrastructure**
	- Before it applies any changes, Terraform prints out the execution plan which describes the actions Terraform will take in order to change your infrastructure to match the configuration.
	- Or you can see the execution plan with **terraform plan** command.
	- Apply the configuration now with the **terraform apply** command.

	- In case if the plan is acceptable, then type 'yes' at the confirmation prompt to proceed. Executing the plan will take a few minutes since Terraform waits for the EC2 instance to become available.

	- You have now created infrastructure using Terraform! Visit the EC2 console and find your new EC2 instance.



**Inspect state**
	- When you applied your configuration, Terraform wrote data into a file called terraform.tfstate. Terraform stores the IDs and properties of the resources it manages in this file, so that it can update or destroy those resources going forward.

	- The **Terraform state file** is the only way Terraform can track which resources it manages, and often contains sensitive information, so you must store your state file securely and restrict access to only trusted team members who need to manage your infrastructure.
	- Inspect the current state using **terraform show** command.

**Manually Managing State**
	- Terraform has a built-in command called **terraform state** for advanced state management. Use the list subcommand to list of the resources in your project's state.
	- eg.  **terraform state list**





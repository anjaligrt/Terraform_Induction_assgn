# ec2_instances_creation_using_terraform



This sample code is used to provision a new ec2 instance on the aws cloud, this code is declarative and can be maintained in a version control system allowing it to be distributed to other teams.


The code is declarative, but what does declarative mean; The code we defined is the state that we want our infrastructure to be in that's the desired state.

Terraform will take care of what is required to go from the current state to the desired state without us having to worry about how to get there, So how does terraform do that.

- Terraform works in three phases init, plan and apply.
	- During the **init** phase terraform initializes the project and identifies the providers to be used for the target environment.
	- During the **plan** phase terraform drafts a plan to get to the target state.
	- And then in the **apply** phase terraform makes the necessary changes required on the target environment to bring it to the desired state.

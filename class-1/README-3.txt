terraform plan is one of the core commands in Terraform's workflow. It allows you to preview the changes that Terraform will make to your infrastructure before actually applying them. This command is essential for understanding the impact of your configuration changes and ensuring that your infrastructure modifications are intentional and correct.

Overview of terraform plan
Purpose: The primary purpose of terraform plan is to create an execution plan, which shows a detailed preview of the actions Terraform will take to achieve the desired state as defined in your configuration files.

Safety Mechanism: It acts as a safety mechanism by allowing you to review the planned changes before applying them, helping to prevent unintended modifications to your infrastructure.

No Changes Applied: Importantly, running terraform plan does not make any changes to your infrastructure. It only calculates and displays the changes that would occur if you were to run terraform apply.

Detailed Breakdown of terraform plan
Let's delve deeper into how terraform plan works and its various components:

1. Reading Configuration Files
Source: Terraform reads all the configuration files (.tf and .tf.json) in your working directory to understand the desired state of your infrastructure.

Variables: It also processes any variable definitions and interpolations to build a complete picture of what resources should exist and how they should be configured.

2. Loading the Current State
State File: Terraform loads the current state of your infrastructure from the state file (terraform.tfstate). This file keeps track of the resources that Terraform manages.

Remote State: If you are using a remote backend (e.g., AWS S3, Azure Blob Storage), Terraform will fetch the latest state from that backend.

3. Comparing Desired State with Current State
Resource Diffing: Terraform compares the desired state (from configuration files) with the current state (from the state file) to identify what changes are necessary to achieve the desired state.

Change Detection: It detects which resources need to be created, updated, or destroyed based on differences between the current and desired states.

4. Generating an Execution Plan
Detailed Plan: Terraform generates a detailed execution plan that lists all the actions it will take. Each planned action is categorized as:

Create (+): Resource will be created.
Update (~): Existing resource will be modified.
Destroy (-): Resource will be destroyed.
Replace (-/+): Resource will be destroyed and recreated.
Change Details: For updates, Terraform shows exactly what attributes will change and their before-and-after values, where possible.

Dependencies: The plan also respects resource dependencies, ensuring that operations occur in the correct order.

5. Optional: Saving the Plan to a File
Plan File: You can save the execution plan to a binary file using the -out flag. This file can later be used with terraform apply to ensure that exactly the planned changes are executed.

Use Cases for Saving Plan:

Review and Approval: Sharing the plan with team members for review before applying changes.
Automation: Integrating into CI/CD pipelines where plan and apply steps are separated.
Security: Ensuring no unexpected changes occur between planning and applying.
Understanding the Output of terraform plan
The output of terraform plan is structured and color-coded (in terminals that support colors) for clarity:

Example Output Structure:
hcl
Copy code
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create
  - destroy
  ~ update in-place
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # aws_instance.example will be created
  + resource "aws_instance" "example" {
      + ami           = "ami-0c55b159cbfafe1f0"
      + instance_type = "t2.micro"
      + tags          = {
          + "Name" = "ExampleInstance"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.
Explanation of Symbols:
+ (Create): Resource does not exist and will be created.
- (Destroy): Resource exists and will be destroyed.
~ (Update in-place): Resource exists and will be updated without replacement.
-/+ (Replace): Resource will be destroyed and recreated due to changes that cannot be made in-place.
Understanding Change Details:
Attribute Changes: For each resource, Terraform lists the attributes that will change, showing their current and proposed values.

Computed Values: Sometimes, values are marked as (known after apply), indicating that Terraform cannot predict the value until the resource is created or updated.

Common Use Cases for terraform plan
Change Validation: Ensuring that your configuration changes will produce the desired effect before modifying live infrastructure.

Review Process: Allowing team members to review and approve infrastructure changes as part of a change management process.

Automation Pipelines: Integrating into automated workflows to programmatically validate and approve infrastructure changes.

Detecting Drift: Identifying unexpected changes in your infrastructure by comparing the current state with the desired state.

Command Options and Flags
terraform plan supports several options and flags to customize its behavior:

Common Flags:
-out=path
Description: Saves the generated execution plan to a file at the specified path.
Usage: terraform plan -out=plan.tfplan
-var 'NAME=VALUE'
Description: Sets a value for a variable.
Usage: terraform plan -var 'instance_type=t2.micro'
-var-file=PATH
Description: Loads variable values from a file.
Usage: terraform plan -var-file=production.tfvars
-target=RESOURCE
Description: Targets a specific resource or module for planning.
Usage: terraform plan -target=aws_instance.example
-refresh=false
Description: Skips refreshing the state before planning. Useful for speeding up plans when you know the state is up-to-date.
Usage: terraform plan -refresh=false
-compact-warnings
Description: Shows warnings in a more compact form.
Usage: terraform plan -compact-warnings
-parallelism=N
Description: Limits the number of concurrent operations. Default is 10.
Usage: terraform plan -parallelism=5
Detailed Flag Descriptions:
-out=path
Purpose: Saves the execution plan to a file, which can be applied later using terraform apply path.
Benefits:
Ensures that the exact plan reviewed is the one applied.
Useful in automated workflows where planning and applying happen at different stages or systems.
-destroy
Purpose: Generates a plan to destroy all resources managed by the current configuration.
Usage: terraform plan -destroy
Use Case: When you intend to tear down all infrastructure managed by Terraform.
-detailed-exitcode
Purpose: Provides detailed exit codes for scripting purposes.
Exit code 0: No changes are needed.
Exit code 1: Error occurred.
Exit code 2: Changes are pending.
Usage: terraform plan -detailed-exitcode
Use Case: Useful in CI/CD pipelines to programmatically determine if changes are necessary.
Example Usages
Basic Plan:
bash
Copy code
# Generate a plan and display it
terraform plan
Plan with Variables:
bash
Copy code
# Generate a plan using variables from a file
terraform plan -var-file=production.tfvars
Save Plan to File:
bash
Copy code
# Generate a plan and save it to a file
terraform plan -out=plan.tfplan

# Apply the saved plan
terraform apply plan.tfplan
Target Specific Resource:
bash
Copy code
# Plan changes for a specific resource only
terraform plan -target=aws_instance.example
Destroy Plan:
bash
Copy code
# Plan destruction of all resources
terraform plan -destroy

# Plan destruction and save to file
terraform plan -destroy -out=destroy.tfplan
Best Practices
Always Review Plans: Before applying changes, carefully review the plan output to ensure all changes are expected and correct.

Use Saved Plans in Production: In production environments, save plans to files and apply them separately to avoid discrepancies between planning and applying stages.

Integrate with Version Control: Keep your configuration files under version control (e.g., Git) and use terraform plan to validate changes proposed in pull requests.

Automate Plan Reviews: Incorporate terraform plan into your CI/CD pipelines to automatically generate and review plans for proposed changes.

Handle Sensitive Data Carefully: Be cautious when variables or outputs contain sensitive information; avoid exposing them in plan outputs or logs.

Conclusion
terraform plan is an indispensable tool in the Terraform workflow, providing visibility and control over infrastructure changes. By generating a detailed execution plan, it empowers you to make informed decisions, prevent unintended consequences, and maintain the integrity and stability of your infrastructure environments.

Next Steps After terraform plan:

terraform apply: To apply the changes as per the plan and modify your infrastructure accordingly.

terraform destroy: To destroy all or specific parts of your infrastructure managed by Terraform.

Further Reading:

Official Terraform Documentation for plan
Terraform Best Practices
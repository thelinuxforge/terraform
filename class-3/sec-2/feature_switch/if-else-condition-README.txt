In Terraform, if-else conditional logic is implemented using ternary expressions. This allows you to evaluate conditions and choose one of two values based on the result.

Syntax:
condition ? true_value : false_value
condition: A boolean expression that is evaluated.
true_value: The value that is returned if the condition evaluates to true.
false_value: The value that is returned if the condition evaluates to false.

Example:
Let's say you want to define an instance type based on a variable:

variable "env" {
  default = "production"
}

resource "aws_instance" "example" {
  instance_type = var.env == "production" ? "t2.large" : "t2.micro"
  ami           = "ami-12345678"
}
In this example, if the variable env is set to "production", the instance type will be "t2.large". If it’s anything else (e.g., "dev"), the instance type will be "t2.micro".
Using Multiple Conditions:
You can nest multiple ternary conditions to handle more complex cases, but this can get difficult to read if overused. Here's an example of handling multiple environments:

instance_type = var.env == "production" ? "t2.large" : (var.env == "staging" ? "t2.medium" : "t2.micro")
In this case:

If env is "production", the instance type will be "t2.large".
If env is "staging", it will be "t2.medium".
For any other environment, it will default to "t2.micro".
Using count or for_each with Conditionals:
You can use conditional expressions within resource definitions that rely on count or for_each as well.

Example (resource creation based on condition):

resource "aws_instance" "example" {
  count = var.create_instance ? 1 : 0  # Creates the resource only if true
  ami   = "ami-12345678"
  instance_type = "t2.micro"
}

In this example, the instance is created only if var.create_instance is true.

Key Points:
Terraform doesn’t have a full if-else block like traditional programming languages but uses ternary expressions for conditional logic.
These are typically used to define resource attributes, outputs, and other dynamic configurations.
Keep conditions simple and readable, as nested conditionals can become hard to manage.
This conditional mechanism allows you to make your Terraform code flexible and adapt to different environments or configurations.
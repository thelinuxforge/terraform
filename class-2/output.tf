output "vpcid" {
  value = aws_vpc.main.id
}

output "vpcarn" {
  value = aws_vpc.main.arn
  
}

output "vpccidr" {
  value = aws_vpc.main.cidr_block
}
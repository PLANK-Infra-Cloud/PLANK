output "master_public_ip" {
  value = aws_instance.master.public_ip
}

output "nodes1_public_ip" {
  value = aws_instance.nodes1.public_ip
}

output "nodes2_public_ip" {
  value = aws_instance.nodes2.public_ip
}

output "runner_public_ip" {
  value = aws_instance.runner.public_ip
}

output "master_private_ip" {
  value = aws_instance.master.private_ip
}

output "nodes1_private_ip" {
  value = aws_instance.nodes1.private_ip
}

output "nodes2_private_ip" {
  value = aws_instance.nodes2.private_ip
}

output "runner_private_ip" {
  value = aws_instance.runner.private_ip
}
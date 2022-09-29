output "aws_ssh_sg" {
    value = [aws_security_group.aws_ssh_sg.*.id]
}
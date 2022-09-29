output "vpc_id" {
    value = [aws_vpc.myvpc.*.id]
}

output "internet_gateway" {
    value = [aws_internet_gateway.igw.*.id]
}
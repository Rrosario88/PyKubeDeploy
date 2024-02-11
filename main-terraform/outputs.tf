output "instance_ip" {
  value = aws_instance.pkd_ec2.public_ip

 /* output "jenkins_ip" 
  value = aws_instance.jenkins.public_ip
  */
}
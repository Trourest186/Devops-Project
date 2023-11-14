# Create EC2
# Cluster
resource "aws_instance" "master" {
  #   source   = "../vpc"
  ami           = var.ami_type
  instance_type = var.instance_type
  subnet_id     = var.sub_id1
  # key_name                    = aws_key_pair.TF_key.key_name
  key_name                    = var.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.security_group1]

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y 
  EOF
  
  connection {
    type = "ssh"
    host = self.public_ip # Understand what is "self"
    user = var.user_ec2[1]
    password = ""
    private_key = var.private_key_content
  }

  provisioner "file" {
    source      = "./Executable_files/master.sh"
    destination = "$HOME"
  }

  provisioner "local-exec" {
    command = "../../Executable_files/update_creation_time.sh ${aws_instance.master.private_ip}"
    working_dir = "Output_files/"
    #on_failure = continue
  }

  tags = {
    Name    = "Master"
    Project = "Devops"
  }
}

resource "aws_instance" "worker" {
  #   source   = "../vpc"
  ami           = var.ami_type
  instance_type = var.instance_type
  subnet_id     = var.sub_id1
  # key_name                    = aws_key_pair.TF_key.key_name
  key_name                    = var.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.security_group1]

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y 
  EOF
  
  connection {
    type = "ssh"
    host = self.public_ip # Understand what is "self"
    user = var.user_ec2[1]
    password = ""
    private_key = var.private_key_content
  }

  provisioner "file" {
    source      = "./Executable_files/worker.sh"
    destination = "$HOME"
  }

  provisioner "local-exec" {
    command = "../../Executable_files/update_creation_time.sh ${aws_instance.worker.private_ip}"
    working_dir = "Output_files/"
    #on_failure = continue
  }

  tags = {
    Name    = "Worker"
    Project = "Devops"
  }
}

# Jenkins and Nginx
resource "aws_instance" "jenkins" {
  #   source   = "../vpc"
  ami           = var.ami_type
  instance_type = var.instance_type
  subnet_id     = var.sub_id2
  # key_name                    = aws_key_pair.TF_key.key_name
  key_name                    = var.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.security_group2]

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y 
  EOF

  tags = {
    Name    = "Jenkins"
    Project = "Devops"
  }
}

# Ansible
resource "aws_instance" "ansible" {
  #   source   = "../vpc"
  ami           = var.ami_type
  instance_type = var.instance_type
  subnet_id     = var.sub_id3
  # key_name                    = aws_key_pair.TF_key.key_name
  key_name                    = var.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.security_group3]

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y 
  EOF

  tags = {
    Name    = "Ansible"
    Project = "Devops"
  }
}  
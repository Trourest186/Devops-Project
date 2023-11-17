# Create EC2
# Cluster
# =============================================== Master ===============================================
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

  tags = {
    Name    = "Master"
    Project = "Devops"
  }
}

resource "time_sleep" "wait_90_seconds_master" {
  depends_on      = [aws_instance.master]
  create_duration = "90s"
}

resource "null_resource" "sync_master" {
  depends_on = [time_sleep.wait_90_seconds_master]
  triggers = {
    always-update = timestamp()
  }

  connection {
    type = "ssh"
    # host = self.public_ip # Understand what is "self"
    host        = aws_instance.master.public_ip
    user        = var.user_ec2[1]
    password    = ""
    private_key = var.private_key_content
  }

  provisioner "file" {
    source      = "./Executable_files/master.sh"
    destination = "/home/${var.user_ec2[1]}/master.sh"
  }

  provisioner "file" {
    source      = "./Executable_files/install_Master.sh"
    destination = "/home/${var.user_ec2[1]}/install_Master.sh"
  }

  provisioner "local-exec" {
    command     = "echo ${aws_instance.master.private_ip} >> creation-time-private-ip.txt"
    working_dir = "Output_files/"
    #on_failure = continue
  }

}

# =============================================== Worker ===============================================
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

  tags = {
    Name    = "Worker"
    Project = "Devops"
  }
}

resource "time_sleep" "wait_90_seconds_worker" {
  depends_on      = [aws_instance.worker]
  create_duration = "90s"
}

resource "null_resource" "sync_worker" {
  depends_on = [time_sleep.wait_90_seconds_worker]
  triggers = {
    always-update = timestamp()
  }

  connection {
    type        = "ssh"
    host        = aws_instance.worker.public_ip
    user        = var.user_ec2[1]
    password    = ""
    private_key = var.private_key_content
  }

  provisioner "file" {
    source      = "./Executable_files/worker.sh"
    destination = "/home/${var.user_ec2[1]}/worker.sh"
  }

  provisioner "local-exec" {
    command     = "echo ${aws_instance.worker.private_ip} >> creation-time-private-ip.txt"
    working_dir = "Output_files/"
    #on_failure = continue
  }

}
# =============================================== Jenkin & Nginx ===============================================
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

  connection {
    type        = "ssh"
    host        = aws_instance.jenkins.public_ip
    user        = var.user_ec2[1]
    password    = ""
    private_key = var.private_key_content
  }

  provisioner "file" {
    source      = "./Executable_files/install_Jenkins.sh"
    destination = "/home/${var.user_ec2[1]}/install_Jenkins.sh"
  }


  tags = {
    Name    = "Jenkins"
    Project = "Devops"
  }
}

# =============================================== Ansible ===============================================
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

  connection {
    type        = "ssh"
    host        = aws_instance.ansible.public_ip
    user        = var.user_ec2[1]
    password    = ""
    private_key = var.private_key_content
  }

  provisioner "file" {
    source      = "./Executable_files/install_Ansible.sh"
    destination = "/home/${var.user_ec2[1]}/install_Ansible.sh"
  }

  provisioner "file" {
    source      = "./Executable_files/install_Ansible.sh"
    destination = "/home/${var.user_ec2[1]}/install_Ansible.sh"
  }

  tags = {
    Name    = "Ansible"
    Project = "Devops"
  }
}

# =============================================== Output ===============================================
resource "time_sleep" "wait_300_seconds_all" {
  depends_on      = [aws_instance.worker, aws_instance.master, aws_instance.jenkins, aws_instance.ansible]
  create_duration = "300s"
}

resource "null_resource" "result" {
  depends_on = [time_sleep.wait_300_seconds_all]
  triggers = {
    always-update = timestamp()
  }

  connection {
    type        = "ssh"
    host        = aws_instance.ansible.public_ip
    user        = var.user_ec2[1]
    password    = ""
    private_key = var.private_key_content
  }

  provisioner "file" {
    source      = "./Output_files/creation-time-private-ip.txt"
    destination = "/home/${var.user_ec2[1]}/creation-time-private-ip.txt"
  }
}

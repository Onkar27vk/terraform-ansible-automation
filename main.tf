provider "aws" {
    region = "ap-outh-1"
}

resource "aws_instance" "ec2_intance" {
    count = var.number_of_instances
    ami = var.ami_id
    subnet_id = var.subnet_id
    instance_type = var.instance_type
    key_name = var.ami_key_pair_name
    security_groups = ["sg-0bdb52d11c916243d"]

    tags = {
        Name = "${var.instance_name}-${count.index + 1}"
      
    } 
}

resource "null_resource" "configure_ssh" {
    count = var.number_of_instances

    connection {
      type = "ssh"
      host = aws_instance.ec2_intance[count.index].public_ip
      user = "ubuntu"
      private_key = file("/home/ubuntu/T/ovk_key.pem")
    }

    provisioner "file" {
        source = "/home/ubuntu/.ssh/id_ed25519.pub"
        destination = "/home/ubuntu/id_ed25519.pub" 

      
    }

    provisioner "remote-exec" { 
        inline = [ 
            "mkdir -p ~/.ssh", 
            "cat /home/ubuntu/id_ed25519.pub >> ~/.ssh/authorized_keys", 
            "chmod 700 ~/.ssh", 
            "chmod 600 ~/.ssh/authorized_keys" 
            ] 
    } 
  
}

resource "null_resource" "disable_strict_host_key_checking" { 
    count = var.number_of_instances 
    
    connection { 
        type  = "ssh"
         
        host  = aws_instance.ec2_intance[count.index].public_ip
        user       = "ubuntu" 
        private_key = file("/home/ubuntu/T/ovk_key.pem") 
        }
        
        provisioner "remote-exec" { 
            inline = [ 
                "echo 'Host *' >> ~/.ssh/config", 
                "echo '  StrictHostKeyChecking no' >> ~/.ssh/config", 
                "echo '  UserKnownHostsFile=/dev/null' >> ~/.ssh/config", 
                "echo '  LogLevel ERROR' >> ~/.ssh/config" 
                ] 
            }

      
} 

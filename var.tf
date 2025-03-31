variable "instance_name" { 
    description = "Name of the instance to be created" 
    default     = "Demo-instance" 
} 

variable "instance_type" { 
    description = "Type of instance to be created" 
    default     = "t2.micro" 
} 

variable "subnet_id" { 
    description = "The VPC subnet the instance(s) will be created in" 
    default    = "subnet-0bdc41f247fc1b009" 
} 

variable "ami_id" { 
    description = "The AMI to use" 
    default     = "ami-0e35ddab05955cf57" 
} 

variable "number_of_instances" { 
    description = "Number of instances to be created" 
    default     = 1 
} 

variable "ami_key_pair_name" { 
    description = "Key pair name for the instances" 
    default     = "ovk_key" 
} 

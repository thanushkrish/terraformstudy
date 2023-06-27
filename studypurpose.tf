terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


#Ec2

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  count = 3    # no. of times the block shuld run and create resources $(metadata)


  lifecycle {                                         #preventing measure to delete or modify resources    $(metadata)
    create_before_destroy = true    #as the name states,creates new resource (not for aws)
    prevent_destroy = true    #prevents destroy when its stated as very important 
    ignore_changes = [ tags , tags["name"]]  #ignores tag feild in every resource and specify specific tag
    
    replace_triggered_by = [aws_instance.id  ]       #when changes occuring in mentioned resource, replace it in current worksspace too


  
  }

  depends_on = [ ]    # controllling flow of creating , what ton create first $(metadata)

  provisioner "local-exec" {

    when = destroy

    
    
  }





  tags = {
    Name = "HelloWorld"
  }
}

pipeline {
    agent any
    
    environment {
        AWS_REGION = 'ap-south-1'
        PACKER_BUILD_NAME = 'ubuntu-image'
    }

    stages {
        stage('Checkout') {
            steps {
                git "https://github.com/shivayogi-31/packer.git"
            }
        }

        stage('Build AMI') {
            steps {
                script {
                    sh '/usr/bin/packer init ubuntu.pkr.hcl'
                    sh '/usr/bin/packer build ubuntu.pkr.hcl'
                    
                    // Use AWS CLI to fetch the latest AMI ID
                    def latestAmi = sh(script: "aws ec2 describe-images --region $AWS_REGION --filters 'Name=name,Values=$PACKER_BUILD_NAME' --query 'Images | sort_by(@, &CreationDate) | [-1].ImageId' --output text", returnStdout: true).trim()

                    // Store the AMI ID as an environment variable
                    env.LATEST_AMI_ID = latestAmi
                    
                    // Print the latest AMI ID
                    echo "Latest AMI ID for $PACKER_BUILD_NAME: $latestAmi"
                }
            }
        }
    
        stage('Infrastructure with Terraform') {
            steps {
                script {
                    
                    def latestAmi = env.LATEST_AMI_ID ?: error("LATEST_AMI_ID is not defined.")

                  
                    sh "terraform init -backend-config=backend.tfvars"
                    sh "terraform apply -var 'latest_ami=$latestAmi' -auto-approve"

                  
                    sh "terraform apply -var 'latest_ami=$latestAmi' -auto-approve -target=aws_autoscaling_group.example"
                }
            }
        }
    }
    
}

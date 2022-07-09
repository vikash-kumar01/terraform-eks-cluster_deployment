pipeline{
    agent any
   
    
    stages{
        
        stage('git checkout'){
            steps{
            git 'https://github.com/vikash-kumar01/terraform-eks-cluster_deployment.git'
            }
        }
        stage('Terraform init'){
            steps{
                sh 'terraform init'
            }
        }
        stage('Terraform Plan'){
            steps{
              sh   'terraform plan --var-file="./config/terraform.tfvars" '
            }
        }
        stage('Action Required for Deployment') {
            steps{
            input "Deploy the resources ?"
            }
         }
        stage('Terraform Apply'){
            steps{
              sh   'terraform apply --var-file="./config/terraform.tfvars" --auto-approve '
            }
        }
        stage('Action Required to destroy resources') {
            steps{
            input "Destroy the resources ?"
            }
         }
        stage('Terraform Destroy'){
            steps{
              sh   'terraform destroy --var-file="./config/terraform.tfvars" --auto-approve '
            }
        }
    }
}



// aws steps and aws credentials plugin

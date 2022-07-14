pipeline {
    agent any
    parameters {
        choice(name: 'action', choices: 'create\ndestroy', description: 'Create/update or destroy the eks cluster.')
        string(name: 'cluster', defaultValue : 'demo-cluster', description: "EKS cluster name.")
        string(name: 'TARGET_ENV', defaultValue: 'PROD', description: 'Environment'  )
        string(name: 'WORKSPACE', defaultValue: 'development', description:'setting up workspace for terraform')
        string(name: 'region', defaultValue : 'us-east-1', description: "AWS region.")
    }
    environment {

        TP_LOG = "WARN"
        PATH = "$TF_HOME:$PATH"
        ACCESS_KEY = credentials('AWS_ACCESS_KEY_ID')
        SECRET_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    
    stages {
               stage('Git CheckOut'){
               steps {
                     git 'https://github.com/vikash-kumar01/terraform-eks-cluster_deployment.git'
                }
            }
 
            stage('TerraformInit'){
            steps {
                    sh 'terraform init -backend-config="access_key=$ACCESS_KEY" -backend-config="secret_key=$SECRET_KEY" -input=false -reconfigure'
                    sh "echo \$PWD"
                    sh "whoami"
            }
        }

        stage('TerraformFormat'){
            steps {
                    sh 'terraform fmt'
            }
        }

        stage('TerraformValidate'){
            steps {
                    sh 'terraform validate'
            }
        }

        stage('TerraformPlan'){
            steps {
                    script {
                        sh """
                        terraform workspace new ${params.WORKSPACE} || true
                        
                        terraform workspace select ${params.WORKSPACE}
                        
                        terraform plan -var 'access_key=$ACCESS_KEY' -var 'secret_key=$SECRET_KEY' -var 'cluster-name=${params.cluster}' --var-file=./config/terraform.tfvars -lock=false -var 'region=${params.region}' \
                        -out terraform.tfplan;echo \$? > status
                        
                        """
                    }
            }
        }
        
        stage('TerraformApply'){
            when {
              expression { params.action == 'create' }
          }
            steps {
                script{
                    def apply = false
                    try {
                        input message: 'Can you please confirm the apply', ok: 'Ready to Apply the Config'
                        apply = true
                    } catch (err) {
                        apply = false
                         currentBuild.result = 'UNSTABLE'
                    }
                    if(apply){
                            sh "terraform apply -var 'access_key=$ACCESS_KEY' -var 'secret_key=$SECRET_KEY' -var 'cluster-name=${params.cluster}' --var-file=./config/terraform.tfvars -var 'region=${params.region}' --auto-approve -lock=false"
                        }
                }
            }
        }
        stage('Terraform Destroy'){
            when {
               expression { params.action == 'destroy' }
             }
            steps {
                script{
                    def destroy = false
                    try {
                        input message: 'Can you please confirm the destroy ?', ok: 'Ready to Apply the Config'
                        destroy = true
                    } catch (err) {
                        destroy = false
                         currentBuild.result = 'UNSTABLE'
                    }
                    if(destroy){
                            sh "terraform destroy -var 'access_key=$ACCESS_KEY' -var 'secret_key=$SECRET_KEY' -var 'cluster-name=${params.cluster}' -var 'region=${params.region}' --var-file=./config/terraform.tfvars --auto-approve -lock=false"
                        }
                }
        }
        }
          
          
        stage('Init DownStreamJob for App Deployment'){
            steps{
                script{
                    def releaseJob = build job: 'eks_app', propagate: false
                    parameters:[
                        [ $class: 'StringParameterValue', name: 'FROM_BUILD', value: "${BUILD_NUMBER}"  ],
                        [ $class: 'BooleanParameterValue', name: 'IS_READY', value: true  ],
                        ]
                    if(releaseJob != "SUCCESS"){
                        echo "Release Status: ${releaseJob.result}"
                    }       
                }
            }
        }
    }
}

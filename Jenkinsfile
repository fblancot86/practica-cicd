pipeline {
    agent {
        label('terraform')
    }
    environment {
        AWS_CREDENTIALS = credentials("AWS-Credentials")
        AWS_ACCESS_KEY_ID = "$AWS_CREDENTIALS_USR"
        AWS_SECRET_ACCESS_KEY = "$AWS_CREDENTIALS_PSW"
        AWS_REGION = "eu-west-1"
    }
    options { 
        disableConcurrentBuilds()
        timeout(time: 1, unit: 'MINUTES')
        timestamps()
    }
    stages {
        stage('Clean') {
            steps {
                sh 'terraform destroy --auto-approve -no-color -var prod_deploy=true'
            }
        }

        stage('Init') {
            steps {
                sh 'terraform init -no-color '
            }
        }
        stage('Validate') {
            steps {
                sh 'terraform validate -no-color '
            }
        }

        stage('Plan') {
            steps {
                sh 'terraform plan -no-color '
            }
        }

        stage('Apply Dev') {
            steps {
                sh 'terraform apply --auto-approve -no-color -var prod_deploy=false'
            }
        }

        stage('Apply Prod') {
            steps {
                timeout(time: 10, unit: 'MINUTES') {
                    input message: 'Are you sure to deploy to Production?', ok: 'Yes, deploy to Production'
                        sh 'terraform apply --auto-approve -no-color -var prod_deploy=true'

                }
            }
        } 
    }
}
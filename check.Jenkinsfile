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
    triggers {
        cron('*/2 * * * *')
    }
    options { 
        disableConcurrentBuilds()
        timeout(time: 1, unit: 'MINUTES')
        timestamps()
    }
    stages {
        stage('Check') {
            steps {
                sh 'sh check-s3.sh'
            }
        }        
    }
}
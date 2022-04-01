pipeline {
    agent {
        label('terraform')
    }
    environment {
        AWS_CREDENTIALS = credentials("AWS-Credentials")
        AWS_ACCESS_KEY_ID = $AWS_CREDENTIALS_USR
        AWS_SECRET_ACCESS_KEY = $AWS_CREDENTIALS_PSW
    }
    options { 
        disableConcurrentBuilds()
        timeout(time: 1, unit: 'MINUTES')
        timestamps()
    }
    stages {
        stage('Init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Apply') {
            steps {
                sh 'terraform apply --auto-approve'
            }
        }

        // stage('Publish') {
        //     steps {
        //         dir('python-application-example') {
        //             timeout(time: 10, unit: 'MINUTES') {
        //                 input message: 'Are you sure to deploy?', ok: 'Yes, deploy to PyPI'
        //                     sh "python -m twine upload dist/* -u $PYPI_CREDENTIALS_USR -p $PYPI_CREDENTIALS_PSW --skip-existing"

        //             }
        //         }
        //     }
        // }        
    }
}
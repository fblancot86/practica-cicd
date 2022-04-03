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
        stage('List S3 Buckets') {
            steps {
                sh 'aws s3 ls | grep acme-storage | awk '{print $3}' > s3.list'
            }
        }

        stage('Check Size') {
            steps {
                sh '''
                in="${1:-s3.list}"
                
                while IFS= read -r bucket
                do
                    echo "Working on $bucket ..."
                    SIZE="$(aws s3 ls s3://$bucket --recursive --summarize | grep Size | awk '{print $3}')"

                    if [ $SIZE -gt 20971520 ]
                    then
                        echo "Emptying $bucket ..."
                        aws s3 rm s3://$bucket --recursive
                    else
                        echo "Bucket size under 20 MiB ($SIZE Bytes) ..."
                    fi
                done < "${in}"

                rm -f s3.list
                '''
            }
        }            
    }
}
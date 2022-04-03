pipelineJob('Práctica Terraform') {
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url("git@github.com:KeepCodingCloudDevops5/cicd-francesc.git")
                        credentials('practica-ssh')

                    }
                    branches("main")
                    scriptPath('infra/Jenkinsfile')
                }
            }
        }
    }
}

pipelineJob('Práctica Check S3') {
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url("git@github.com:KeepCodingCloudDevops5/cicd-francesc.git")
                        credentials('practica-ssh')

                    }
                    branches("main")
                    scriptPath('checkSize/Jenkinsfile')
                }
            }
        }
    }
}
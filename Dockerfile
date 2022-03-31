FROM fblanco86/base-jenkins-agent

# ENTRYPOINT terraform --version && aws --version

RUN apt-get update && apt-get install curl -y && \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
    apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
    apt-get update && apt-get install terraform -y && \
    apt-get install awscli -y


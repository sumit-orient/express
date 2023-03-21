
node('master') {
    dir("/home/ubuntu/abc"){
        sh "git clone git@github.com:sumit-orient/express.git"
        // sh "git pull"
    }

    dir("/home/ubuntu/abc/express"){
        // sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 433590147323.dkr.ecr.us-east-1.amazonaws.com"
        sh "docker build -t pearl-ecr ."
        sh "docker tag pearl-ecr:latest 433590147323.dkr.ecr.us-east-1.amazonaws.com/pearl-ecr:latest"
        // sh "docker push 433590147323.dkr.ecr.us-east-1.amazonaws.com/pearl-ecr:latest"
        sh "sudo systemctl restart docker-compose.service"
    }
}
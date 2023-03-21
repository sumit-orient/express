
pipeline {
    agent any
    stages {
        stage('Pull configs'){
            agent { label 'master'}
            steps{
                // dir("/home/ubuntu/pearl"){
                //     sh "git clone git@github.com:sumit-orient/express.git"
                // }
                dir("/home/ubuntu/pearl/express"){
                    sh "git pull"
                }
            }
        }

       stage('Docker Image Build & Push To ECR'){
            agent { label 'master'}
            steps {
                script {
                    stage ("Docker Image Builds") {
                                 sh '''
                                    /usr/local/bin/aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 658299376927.dkr.ecr.us-east-1.amazonaws.com

                                    docker build -t pearl-ecr /home/ubuntu/pearl/express/

                                    docker tag pearl-ecr:latest 658299376927.dkr.ecr.us-east-1.amazonaws.com/pearl-ecr:latest

                                    docker push 658299376927.dkr.ecr.us-east-1.amazonaws.com/pearl-ecr:latest

                                '''
                    }
                }
            }
        }
        stage('Docker Image Deployment'){
            agent { label 'expressjs'}
            steps {
                script {
                    stage ("Deploy Docker Image") {
                        sh '''
                        /usr/local/bin/aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 658299376927.dkr.ecr.us-east-1.amazonaws.com/pearl-ecr:latest

                        sudo systemctl restart pearl.service
                        '''
                    }
                }
            }
        }
    }
}
    




// node('master') {
//     dir("/home/ubuntu/abc"){
//         sh "git clone git@github.com:sumit-orient/express.git"
//         // sh "git pull"
//     }

//     dir("/home/ubuntu/abc/express"){
//         // sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 433590147323.dkr.ecr.us-east-1.amazonaws.com"
//         sh "docker build -t pearl-ecr ."
//         sh "docker tag pearl-ecr:latest 433590147323.dkr.ecr.us-east-1.amazonaws.com/pearl-ecr:latest"
//         // sh "docker push 433590147323.dkr.ecr.us-east-1.amazonaws.com/pearl-ecr:latest"
//         sh "sudo systemctl restart docker-compose.service"
//     }
// }

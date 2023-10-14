pipeline {
    agent any

    environment {
        AWS_ACCOUNT_ID = "422351898213"
        AWS_DEFAULT_REGION = "ap-northeast-1"
        IMAGE_REPO_NAME = "laravel"
        IMAGE_TAG = "latest"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
    }

    stages {
        stage("CICD start") {
            steps {
                echo 'CICD start'
            }
        }

        stage("logging AWS ECR") {
            steps {
                script {
                    sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
                }
            }
        }

        stage("build image") {
            steps {
                script {
                    dockerImage = docker.build "${IMAGE_REPO_NAME} : ${IMAGE_TAG}"
                }
            }
        }

        stage("push to AWS ECR") {
            steps {
                script {
                    sh "docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:${IMAGE_TAG}"
                    sh "docker push ${REPOSITORY_URI}:${IMAGE_TAG}"
                }
            }
        }
    }
}

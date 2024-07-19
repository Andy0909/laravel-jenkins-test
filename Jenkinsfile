pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID = "422351898213"
        AWS_DEFAULT_REGION = "ap-northeast-1"
        IMAGE_REPO_NAME = "laravel"
        IMAGE_TAG = "latest"
        REPOSITORY_URI = "422351898213.dkr.ecr.ap-northeast-1.amazonaws.com/laravel"
        CLUSTER = "phpProjectCluster"
        SERVICE = "laravel-service-lb"
    }
   
    stages {
        stage('Logging into AWS ECR') {
            steps {
                script {
                    sh """aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"""
                }  
            }
        }
        
        stage('Cloning Git') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/stage']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '', url: 'https://github.com/Andy0909/laravel-jenkins-test.git']]])     
            }
        }
  
        // Building Docker images
        stage('Building image') {
            steps {
                script {
                    sh """ docker build -t ${IMAGE_REPO_NAME}:${IMAGE_TAG} ."""
                }
            }
        }
   
        // Uploading Docker images into AWS ECR
        stage('Pushing to ECR') {
            steps {  
                script {
                    sh """docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:${IMAGE_TAG}"""
                    sh """docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"""
                }
            }
        }
        
        stage('Deploy to ECS') {
            steps {
                script {
                    sh """aws ecs update-service --cluster ${CLUSTER} --service ${SERVICE} --force-new-deployment"""
                }
            }
        }
    }
}
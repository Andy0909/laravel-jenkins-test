pipeline {
    agent any

    environment {
        registry = "422351898213.dkr.ecr.ap-northeast-1.amazonaws.com/laravel"
    }

    stages {
        stage("CICD start") {
            steps {
                echo 'CICD start'
            }
        }

        stage("build image") {
            steps {
                script {
                    dockerImage = docker.build registry
                }
            }
        }
    }
}

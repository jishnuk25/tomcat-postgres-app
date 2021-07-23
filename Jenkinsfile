def CONTAINER_NAME="Loginwebapp"
def CONTAINER_TAG="latest"
def DOCKER_HUB_USER="250795"
def HTTP_PORT="8080"

pipeline {

    agent { 
        label 'jenkins-slave-node'
        }

    environment {
        PATH = "/usr/share/maven/bin:$PATH"
    }

    stages {
        stage("Checkout") {
            steps {
                git url:'https://github.com/jishnuk25/Java-Mysql-simple-Login-Web-application.git', credentialsId:'00548fae-616-47bf-a7f0-5add59ab5ded'
            }
        }
        stage("Build") {
            steps { 
                sh "mvn clean install"
            }
        }
        stage("compose-up") {
            steps {
                sh "docker-compose up --build"
            }
        }
        stage("Code quality") {
            steps {
                script {
                    try {
                        sh "mvn sonar:sonar"
                    }
                    catch(error) {
                        echo "The sonar server could not be reached ${error}"
                        currentBuild.result = 'ABORTED'
                    }
                }
            }
        }
        stage("Image build") {
            steps{
                imagebuild(CONTAINER_NAME, CONTAINER_TAG)
            }
        }
    }
}

def imagebuild(containerName, tag) {
    sh "docker build -t $containerName:$tag --pull --no-cache ."
}
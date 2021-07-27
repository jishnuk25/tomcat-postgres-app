def CONTAINER_NAME = "loginwebapp"
def CONTAINER_TAG = "latest"
def DOCKER_HUB_USER = "25795"
def HTTP_PORT = "8080"

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
        stage("Image prune") {
            steps {
            imagePrune(CONTAINER_NAME)
            }
        }
        stage("Image build") {
            steps {
            imageBuild(CONTAINER_NAME, CONTAINER_TAG)
            }
        }
        stage("Image push") {
            steps{
                withCredentials([usernamePassword(credentialsId:'dockerHubAccount', passwordVariable:'PASSWORD', usernameVariable:'USERNAME')]) {
                    imagePush(CONTAINER_NAME, CONTAINER_TAG, USERNAME, PASSWORD)
                }
            }
        }
        stage("Deploy") {
            steps{
                deploy(CONTAINER_NAME, CONTAINER_TAG, DOCKER_HUB_USER, HTTP_PORT)
            }
        }
    }
}

def imagePrune(containerName) {
    try {
    sh "docker image prune -f"
    sh "docker stop $containerName"
    }
    catch(error) {}
}

def imageBuild(containerName, tag) {
    sh "docker build -t $containerName:$tag -t $containerName --pull --no-cache ."
    echo "Image ${containerName}:${tag} "
}

def imagePush(containerName, tag, dockerUser, dockerPassword) {
    sh "docker login -u $dockerUser -p $dockerPassword"
    sh "docker tag $containerName:$tag $dockerUser/$containerName:$tag"
    sh "docker push $dockerUser/$containerName:$tag"
    echo "${containerName}:${tag} pushed to Docker Hub successfully"
}

def deploy(containerName, tag, dockerHubUser, httpPort) {
    sh "docker pull $dockerHubUser/$containerName:$tag"
    sh "docker run -rm -d -p $httpPort:$httpPort --name $containerName $dockerHubUser/$containerName:$tag"
    echo "${containerName} startd on port: ${httpPort} (http)"
}
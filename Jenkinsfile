pipeline {
    agent {
        kubernetes {
            yamlFile 'jenkins_pod_templates/golang.yaml'
        }
    }

    stages {
        stage('Test') {
            steps {
                container('golang') {
                    sh '''
                    go mod download

                    go test ./...
                    '''
                }
            }
        }
        stage('Build') {
            agent {
                kubernetes {
                    yamlFile 'jenkins_pod_templates/dind.yaml'
                }
            }
            steps {
                container('dind') {
                    sh '''
                    docker info

                    docker build -t simple-go-service:${env.BUILD_NUMBER} .
                    '''
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
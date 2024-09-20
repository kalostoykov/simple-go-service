pipeline {
    agent {
        kubernetes {
            yamlFile 'jenkins_pod_templates/KubernetesPod.yaml'
        }
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
            }
        }
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
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
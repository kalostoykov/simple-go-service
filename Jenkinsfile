pipeline {
    agent {
        kubernetes {
            yamlFile 'jenkins_pod_templates/KubernetesPod.yaml'
        }
    }

    stages {
        // stage('Test') {
        //     steps {
        //         container('golang') {
        //             sh '''
        //             go mod download

        //             go test ./...
        //             '''
        //         }
        //     }
        // }
        stage('Build') {
            steps {
                container('docker') {
                    sh '''
                    docker info
                    docker build -t simple-go-service:${env.BUILD_NUMBER} .
                    '''
                }
            }
        }
        // stage('Deploy') {
        //     steps {
        //         echo 'Deploying....'
        //     }
        // }
    }
}
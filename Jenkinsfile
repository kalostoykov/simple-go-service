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
                    go get github.com/onsi/ginkgo/v2
                    go install github.com/onsi/ginkgo/v2/ginkgo

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
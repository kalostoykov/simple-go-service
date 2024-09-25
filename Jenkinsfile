pipeline {
    agent {
        kubernetes {
            yamlFile 'jenkins_pod_templates/KubernetesPod.yaml'
        }
    }

    environment {
        DOCKER_REGISTRY_HOST="https://index.docker.io/"
        DOCKER_REGISTRY_NAME="kalostoykov"
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

                container('helm') {
                    sh '''
                    helm template \
                    --namespace simple-go-service \
                    --validate \
                    -f envs/dev/helm_values.yaml \
                    simple-go-service \
                    ./charts/simple-go-service
                    '''
                }
            }
        }

        // stage('Build') {
        //     steps {
        //         container('docker') {
        //             sh '''
        //             docker build -t ${DOCKER_REGISTRY_NAME}/simple-go-service:${env.BUILD_NUMBER} .
        //             '''
        //             withCredentials([$class: 'UsernamePasswordMultiBinding', credentialsId: dockerhub, usernameVariable: 'REGISTRY_USERNAME', passwordVariable: 'REGISTRY_PASSWORD']) {
        //                 sh '''
        //                 docker login -u ${REGISTRY_USERNAME} -p ${REGISTRY_PASSWORD} ${DOCKER_REGISTRY_HOST}
        //                 docker push ${DOCKER_REGISTRY_NAME}/simple-go-service:${env.BUILD_NUMBER}
        //                 '''
        //             }
        //         }
        //     }
        // }

        stage('Deploy') {
            steps {
                container('helm') {
                    sh '''
                    helm upgrade \
                    --namespace simple-go-service \
                    -f envs/dev/helm_values.yaml \
                    simple-go-service \
                    ./charts/simple-go-service
                    '''
                }
            }
        }
    }
}
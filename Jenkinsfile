pipeline {
    agent {
        kubernetes {
            yamlFile 'jenkins_pod_templates/KubernetesPod.yaml'
        }
    }

    environment {
        DOCKER_REGISTRY_HOST="https://index.docker.io/"
        DOCKER_REGISTRY_NAME="kalostoykov"
        HELM_RELEASE_NAME="simple-go-service"
        HELM_RELEASE_NAMESPACE="simple-go-service"
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
                    --namespace ${HELM_RELEASE_NAMESPACE} \
                    --validate \
                    -f envs/dev/helm_values.yaml \
                    ${HELM_RELEASE_NAME} \
                    ./charts/${HELM_RELEASE_NAME}
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
            when {
                branch 'master'
            }
            steps {
                container('helm') {
                    sh '''
                    helm upgrade \
                    --namespace ${HELM_RELEASE_NAMESPACE} \
                    -f envs/dev/helm_values.yaml \
                    ${HELM_RELEASE_NAME} \
                    ./charts/${HELM_RELEASE_NAME}
                    '''
                }
            }
        }
    }
}
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
                container('maven') {
                    sh 'echo MAVEN_CONTAINER_ENV_VAR = ${CONTAINER_ENV_VAR}'
                    sh 'mvn -version'
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
pipeline {
    agent any

    environment {
        SONARQUBE_SERVER = 'http://localhost:9000'
        PROJECT_KEY = 'jobportalsonar'
        SONARQUBE_TOKEN = 'sqa_5f11f398071eac0f8d8946a28632d23e4667c894'
        SOURCE_DIR = 'automation-online-job-management-system-python-django'
        DOCKER_IMAGE = 'sumitchavan0110/jobportalimage:v9'
    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    def gitRepoUrl = 'https://github.com/sumitchavan0110/automation-online-job-management-system-python-django.git'
                    checkout([$class: 'GitSCM', branches: [[name: 'main']],
                              userRemoteConfigs: [[url: gitRepoUrl]]])
                }
            }
        }

        stage('Run SonarQube Analysis') {
            steps {
                script {
                    withSonarQubeEnv('MySonarQube') {
                        sh """
                            sonar-scanner \
                            -Dsonar.projectKey=${PROJECT_KEY} \
                            -Dsonar.sources=${SOURCE_DIR} \
                            -Dsonar.host.url=${SONARQUBE_SERVER} \
                            -Dsonar.login=${SONARQUBE_TOKEN}
                        """
                    }
                }
            }
        }

        stage('Quality Gate Status Check') {
            steps {
                script {
                    def qualityGate = waitForQualityGate()
                    if (qualityGate.status != 'OK') {
                        error "Quality Gate failed: ${qualityGate.status}"
                    } else {
                        echo "Quality Gate passed: ${qualityGate.status}"
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh """
                        docker-compose build
                    """
                }
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockercred', 
                        usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                        sh """
                            docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD
                            docker push ${DOCKER_IMAGE}
                        """
                    }
                }
            }
        }

        stage('Kubernetes Deployment') {
            steps {
                script {
                    withKubeConfig([credentialsId: 'mymini_cred']) {
                        sh """
                            kubectl apply -f job_dep.yml
                            kubectl apply -f service.yml
                            kubectl get pods
                            kubectl get deployments
                        """
                    }
                }
            }
        }
    }
}

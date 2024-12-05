pipeline {
    agent any

    environment {
        // SonarQube Configuration
        SONARQUBE_SERVER = 'http://172.28.95.37:9000'  // Update this to your SonarQube server URL
        SONARQUBE_PROJECT_KEY = 'jobportal'  // Update this to your SonarQube project key
        SONARQUBE_TOKEN = 'sqp_d71cf354e237a65f6011cd03657d2fa738614901'  // Your SonarQube token
        SOURCE_DIR = 'automation-online-job-management-system-python-django'  // Path to your source code

        // Docker Configuration
        DOCKER_IMAGE = 'sumitchavan0110/jobportalimage:v9'
        DOCKER_REPO = 'sumitchavan0110/jobportalimage'
        DOCKER_TAG = 'v9'
    }

    stages {
        // Stage 1: Git Clone
        stage('Git Clone') {
            steps {
                script {
                    // Clean up workspace if necessary
                    sh "rm -rf *"
                    // Clone the repository
                    sh "git clone https://github.com/sumitchavan0110/automation-online-job-management-system-python-django.git"
                }
            }
        }

        // Stage 2: SonarQube Analysis
        stage('SonarQube Analysis') {
            steps {
                script {
                    // Run SonarQube analysis on the source code
                    withSonarQubeEnv('MySonarQube') {
                        sh '''
                            cd $SOURCE_DIR
                            sonar-scanner \
                                -Dsonar.projectKey=$SONARQUBE_PROJECT_KEY \
                                -Dsonar.sources=. \
                                -Dsonar.host.url=$SONARQUBE_SERVER \
                                -Dsonar.login=$SONARQUBE_TOKEN
                        '''
                    }
                }
            }
        }

        // Stage 3: Wait for SonarQube Quality Gate
        stage('Quality Gate') {
            steps {
                script {
                    // Wait for SonarQube quality gate to pass
                    def qualityGate = waitForQualityGate()
                    if (qualityGate.status != 'OK') {
                        error "Quality Gate failed: ${qualityGate.status}"
                    } else {
                        echo "Quality Gate passed: ${qualityGate.status}"
                    }
                }
            }
        }

        // Stage 4: Docker Build
        stage('Docker Build') {
            steps {
                script {
                    // Navigate to the cloned repository and build the Docker image
                    sh '''
                        cd automation-online-job-management-system-python-django
                        docker build -t $DOCKER_REPO:$DOCKER_TAG .
                    '''
                }
            }
        }

        // Stage 5: Push Docker Image to Docker Hub
        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    // Log in to Docker Hub using Jenkins credentials
                    withCredentials([usernamePassword(credentialsId: 'docker-cred', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                        // Docker login
                        sh "docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD"
                        // Push the Docker image to Docker Hub
                        sh "docker push $DOCKER_REPO:$DOCKER_TAG"
                    }
                }
            }
        }

        /* Uncomment and modify if you want to add Kubernetes deployment stages
        stage('Start Minikube') {
            steps {
                sh '/usr/local/bin/minikube delete'
                sh '/usr/local/bin/minikube start'
            }
        }

        stage('Kubectl Deployment') {
            steps {
                sh '''
                    cd automation-online-job-management-system-python-django
                    /usr/local/bin/kubectl apply -f deployment.yml
                '''
            }
        }

        stage('Kubectl Service') {
            steps {
                sh '''
                    cd automation-online-job-management-system-python-django
                    /usr/local/bin/kubectl apply -f service.yml
                '''
            }
        }

        stage('List Minikube Services') {
            steps {
                sh '/usr/local/bin/minikube service --all'
            }
        }
        */
    }
}




/*pipeline {
    agent any

    stages {
        stage('git clone') {
            steps {
                script {
                    sh "sudo rm -r *"
                    sh "git clone https://github.com/sumitchavan0110/automation-online-job-management-system-python-django.git"
                }
            }
        }

        stage('docker build') {
            steps {
                script {
                    sh '''
                        cd automation-online-job-management-system-python-django
                        docker build -t sumitchavan0110/jobportalimage:v9 .
                    '''
                }
            }
        }

        stage('Push Docker Images to Docker Hub') {
            steps {
                script {
                    // Log in to Docker Hub using Jenkins credentials
                    withCredentials([usernamePassword(credentialsId: 'docker-cred', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                        sh "docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD"
                        // Push the Docker images to your Docker Hub repository
                        sh 'docker push sumitchavan0110/jobportalimage:v9'
                    }
                }
            }
        }
        /*stage('Start Minikube') {
            steps {
                sh '/usr/local/bin/minikube delete'
                sh '/usr/local/bin/minikube start'
                
            }
        }

        stage('Kubectl deployment') {
            steps {
                 sh '''
                        cd automation-online-job-management-system-python-django
                        /usr/local/bin/kubectl apply -f deployment.yml
                    '''
                
            }
        }

        stage('Kubectl service') {
            steps {
                sh '''
                        cd automation-online-job-management-system-python-django
                        /usr/local/bin/kubectl apply -f service.yml
                    '''
            }
        }

        

        stage('List Minikube Services') {
            steps {
                sh '/usr/local/bin/minikube service --all'
            }
        }*/
    }
}/*


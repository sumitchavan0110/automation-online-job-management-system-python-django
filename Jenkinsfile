pipeline {
    agent any

    stages {
        stage('git clone') {
            steps {
                script {
                    sh "git clone https://github.com/sumitchavan0110/automation-online-job-management-system-python-django.git"
                }
            }
        }

        stage('docker build') {
            steps {
                script {
                    sh '''
                        cd automation-online-job-management-system-python-django
                        docker build -t sumitchavan0110/jobportalimage:v3 .
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
                        sh 'docker push sumitchavan0110/jobportalimage:v3'
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
}

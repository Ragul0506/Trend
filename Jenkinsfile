pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'sarwanragul'
        DOCKER_IMAGE = 'trend'
        DOCKER_TAG = 'latest'
        AWS_REGION = 'ap-south-1'
        KUBE_CONFIG = '/home/ubuntu/.kube/config'  // adjust path if different
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Vennilavan12/Trend.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh """
                    docker build -t ${DOCKERHUB_USER}/${DOCKER_IMAGE}:${DOCKER_TAG} .
                    """
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', 
                                                  usernameVariable: 'USERNAME', 
                                                  passwordVariable: 'PASSWORD')]) {
                    sh """
                    echo "$PASSWORD" | docker login -u "$USERNAME" --password-stdin
                    docker push ${DOCKERHUB_USER}/${DOCKER_IMAGE}:${DOCKER_TAG}
                    """
                }
            }
        }

        stage('Deploy to EKS') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG_FILE')]) {
                    sh """
                    export KUBECONFIG=${KUBECONFIG_FILE}
                    kubectl apply -f deployment.yaml
                    kubectl apply -f service.yaml
                    """
                }
            }
        }
    }

    post {
        success {
            echo "✅ Application deployed successfully to EKS"
        }
        failure {
            echo "❌ Deployment failed. Check logs."
        }
    }
}


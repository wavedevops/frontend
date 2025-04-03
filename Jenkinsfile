pipeline {
    agent { label 'workstation' }

//     environment {
//         JFROG_API_KEY = credentials('cmVmdGtuOjAxOjE3NzUyMjkyODk6RDl0V01hY3ozSEdSVUkyZU5OOXhLUFAwbEV5')  // Fetch API key securely
//     }

    stages {
        stage('Code Quality') {
            when {
                allOf {
                    expression { env.TAG_NAME != env.GIT_BRANCH }
                }
            }
            steps {
                echo 'Code Quality Check: OK'
            }
        }

        stage('Unit Tests') {
            when {
                allOf {
                    expression { env.TAG_NAME != env.GIT_BRANCH }
                    branch 'main'
                }
            }
            steps {
                echo 'Running Unit Tests: CI'
            }
        }

        stage('Release') {
            when {
                expression { env.TAG_NAME ==~ ".*" }
            }
            steps {
                script {
                    if (!env.TAG_NAME) {
                        error "❌ TAG_NAME is not set. Ensure you're running this as a tagged build."
                    }
                }
                sh 'rm -f frontend-${TAG_NAME}.zip'
                sh 'zip -r frontend-${TAG_NAME}.zip *'
                sh """
//                     curl -sSf -H "X-JFrog-Art-Api: ${JFROG_API_KEY}" -X PUT -T frontend-${TAG_NAME}.zip "https://jfrog.chaitu.net/artifactory/frontend/frontend-${TAG_NAME}.zip"
                    curl -H "X-JFrog-Art-Api: cmVmdGtuOjAxOjE3NzUyMjkyODk6RDl0V01hY3ozSEdSVUkyZU5OOXhLUFAwbEV5" \
                         -X PUT -T frontend-${TAG_NAME}.zip "https://jfrog.chaitu.net/artifactory/frontend/frontend-${TAG_NAME}.zip"
                """
            }
        }
    }

    post {
        always {
            echo "🧹 Cleaning up workspace..."
            deleteDir()  // Deletes the workspace after job runs
        }
    }
}

pipeline {
    agent { label 'workstation' }

    stages {
        stage('Code Quality') {
            when {
                allOf {
                    expression { env.TAG_NAME != env.GIT_BRANCH }
                }
            }
            steps {
                echo '✅ Code Quality Check: OK'
            }
        }

        stage('Unit Tests') {
            when {
                allOf {
                    expression { env.TAG_NAME != env.GIT_BRANCH }
                    branch 'main'
                }
            }
            steps {
                echo '🔬 Running Unit Tests: CI'
            }
        }

        stage('Release') {
            when {
                expression { env.TAG_NAME ==~ ".*" }
            }
            steps {
                script {
                    if (!env.TAG_NAME) {
                        error "❌ TAG_NAME is not set. Ensure you're running this as a tagged build."
                    }
                }

                sh 'rm -f frontend-${TAG_NAME}.zip'
                sh 'zip -r frontend-${TAG_NAME}.zip *'

                withCredentials([string(credentialsId: 'JFROG_API_KEY', variable: 'API_KEY')]) {
                    sh """
                        curl -H "X-JFrog-Art-Api: cmVmdGtuOjAxOjE3NzUyMjkyODk6RDl0V01hY3ozSEdSVUkyZU5OOXhLUFAwbEV5" -X PUT -T frontend-${TAG_NAME}.zip "https://jfrog.chaitu.net/artifactory/frontend/frontend-${TAG_NAME}.zip"
                    """
                }
            }
        }
    }

    post {
        always {
            echo "🧹 Cleaning up workspace..."
            deleteDir()
        }
    }
}

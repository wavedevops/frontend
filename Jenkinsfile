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
                echo 'OK'
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
                echo 'CI'
            }
        }

        stage('Release') {
            when {
                expression { env.TAG_NAME ==~ ".*" }
            }
            steps {
                sh 'zip -r frontend-${TAG_NAME}.zip *'
                sh """
                    curl -sSf -u admin:${JENKINS_PASSWORD} -X PUT -T frontend-${TAG_NAME}.zip "https://jfrog.chaitu.net/artifactory/frontend/frontend-${TAG_NAME}.zip"
                """

                // Docker Build & Push
                // sh 'docker build -t 739561048503.dkr.ecr.us-east-1.amazonaws.com/frontend:${TAG_NAME} .'
                // sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 739561048503.dkr.ecr.us-east-1.amazonaws.com'
                // sh 'docker push 739561048503.dkr.ecr.us-east-1.amazonaws.com/frontend:${TAG_NAME}'
            }
        }
    }
}

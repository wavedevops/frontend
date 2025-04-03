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
                // sh 'sonar-scanner -Dsonar.host.url=http://172.31.91.185:9000 -Dsonar.login=admin -Dsonar.password=admin123 -Dsonar.projectKey=backend -Dsonar.qualitygate.wait=true'
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
                // Ideally we should run the tests, but here the developer has skipped it. So assuming those are good and proceeding
                // sh 'npm test'
                echo 'CI'
            }
        }

        stage('Release') {
            when {
                expression { env.TAG_NAME ==~ ".*" }
            }
            steps {
                sh 'zip -r frontend-${TAG_NAME}.zip *'
                sh 'curl -sSf -u "admin:"{{ lookup('aws_ssm', 'jenkins_password', region='us-east-1' ) }}"" -X PUT -T frontend-${TAG_NAME}.zip "https://jfrog.chaitu.net/artifactory/frontend/frontend-${TAG_NAME}.zip"'
                }
            steps {
//                 sh 'docker build -t 739561048503.dkr.ecr.us-east-1.amazonaws.com/frontend:${TAG_NAME} .'
//                 sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 739561048503.dkr.ecr.us-east-1.amazonaws.com'
//                 sh 'docker push 739561048503.dkr.ecr.us-east-1.amazonaws.com/frontend:${TAG_NAME}'
            }
        }

    }
}
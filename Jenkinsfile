pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M2_HOME" and add it to the path.
        maven "M2_HOME"
    }

    stages {
        stage('Build') {
            steps {
                // Get some code from a GitHub repository
                git 'https://github.com/NikhilLara/FINAL_HEALTH_CARE.git'

                // Run Maven on a Unix agent.
                sh "mvn -Dmaven.test.failure.ignore=true clean package"
            }
        }
        stage('Generate Test Reports') {
            steps {
                publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/FINAL_HEALTH_CARE/target/surefire-reports', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])
            }
        }
        stage('Create Docker-Image') {
            steps {
                sh 'docker build -t nikhillara1989/final_health_care:1.0 .'
            }
        }
        stage('Docker-Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-login', passwordVariable: 'dockerpassword', usernameVariable: 'dockerlogin')]) {
                sh 'docker login -u ${dockerlogin} -p ${dockerpassword}'
                }
            }
        }
        stage('Docker-Push-Image') {
            steps {
                sh 'docker push nikhillara1989/final_health_care:1.0'
            }
        }
    }
}

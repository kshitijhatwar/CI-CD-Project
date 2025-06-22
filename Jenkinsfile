pipeline{
    agent any
    tools{
        jdk "JDK17"
        maven "MAVEN3.9"
    }

    environment {
        SNAP_REPO = 'vprofile-snapshot'
        NEXUS_USER = 'admin'
        NEXUS_PASS = 'Thanks@123'
        RELEASE_REPO = 'vprofile-release'
        CENTRAL_REPO = 'vpro-maven-central'
        NEXUSIP = '13.221.241.248:8081'
        NEXUSPORT = '8081'
        NEXUS_GRP_REPO = 'vpro-maven-group'
        NEXUS_LOGIN = 'nexuslogin'
        NEXUS_VERSION = 'nexus3'
        NEXUS_PROTOCOL = 'http'
        SONARSERVER = 'sonarserver'
        SONARSCANNER = 'sonarscanner'
    }

    stages{
        stage('mvn build'){
            steps {
                sh 'mvn -s settings.xml install'
            }
            post {
                success {
                    echo "ok"
                    archiveArtifacts artifacts: '**/*.war'
                }
            }
        }

        stage('MVN Test') {
            steps {
                sh 'mvn -s settings.xml test'
            }
        }

        stage('anala') {
            steps{
                sh 'mvn -s settings.xml checkstyle:checkstyle'
            }
        }

        stage('sonar') {

            environment {
             scannerHome = tool 'sonarscanner'
          }
            
            steps {
                withSonarQubeEnv("${SONARSERVER}") {
                    sh '''${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=vprofile \
                    -Dsonar.projectName=vprofile \
                    -Dsonar.projectVersion=1.0 \
                    -Dsonar.source=src/ \
                    -Dsonar.java.binaries=target/test-classes/com/visualpathit/account/controllerTest \
                    -Dsonar.junit.reportsPath=target/surefire-reports/ \
                    -Dsonar.jacoco.reportsPath=target/jacoco.exec \
                    -Dsonar.java.checkstyle.reportPaths=target/checkstyle-result.xml'''
                }
            }
        }

        stage('upload artifact') {
            steps{
                nexusArtifactUploader(
                nexusVersion: NEXUS_VERSION,
                protocol: NEXUS_PROTOCOL,
                nexusUrl: NEXUSIP,
                groupId: NEXUS_GRP_REPO,
                version: "${BUILD_NUMBER}",
                repository: RELEASE_REPO,
                credentialsId: NEXUS_LOGIN,
                artifacts: [
                    [artifactId: 'vproapp',
                    classifier: '',
                    file: "target/vprofile-v2.war",
                    type: "war"]
                            ]
                            )
                    
		    
            }
        }
    }


}

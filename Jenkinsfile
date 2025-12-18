pipeline {
  agent any

  parameters {
    booleanParam(name: 'SKIP_DEPLOY', defaultValue: false, description: 'Skip container deployment (useful for build-only runs)')
  }

  environment {
    IMAGE_NAME = 'nginx-hello'
    REGISTRY_URL = '10.33.109.104'
    REGISTRY_REPO = 'httpd/nginx-hello'
    harbor = credentials('harbor')
  }

  stages {
    stage('Verify Tooling') {
      steps {
        sh 'docker version'
        sh 'docker info'
      }
    }

    stage('Checkout SCM') {
      steps {
        checkout scm
      }
    }

    stage('Build Docker Image') {
      steps {
        sh "docker build -t ${IMAGE_NAME} ."
      }
    }

    stage('Deploy Container') {
      when {
        expression { return !params.SKIP_DEPLOY }
      }
      steps {
        sh "docker rm -f ${IMAGE_NAME} || true"
        sh "docker run -d --name ${IMAGE_NAME} -p 8080:8080 ${IMAGE_NAME}"
      }
    }

    stage('Push to Registry') {
      steps {
        sh "docker tag ${IMAGE_NAME} ${REGISTRY_URL}/${REGISTRY_REPO}"
        sh 'echo $harbor_PSW | docker login $REGISTRY_URL -u $harbor_USR --password-stdin'
        sh "docker push ${REGISTRY_URL}/${REGISTRY_REPO}"
      }
    }
  }

  post {
    always {
      sh 'docker ps'
    }
    success {
      echo 'Pipeline completed successfully!'
    }
    failure {
      echo 'Pipeline failed. Check the logs for details.'
    }
  }
}

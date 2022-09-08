pipeline {
  agent any
  environment {
    harbor=credentials('harbor')
  }
  stages {
    stage("verify tooling") {
      steps {
        sh 'docker version'
        sh 'docker info'
      }
    }
    stage("Build docker image") {
      steps {
        sh 'docker build -t nginx-hello .'
      }
    }
    stage("Remove orpans containers") {
      steps {
        sh 'docker rm -f nginx-hello'
      }
    }
    stage("Run a new nginx-hello container") {
      steps {
        sh 'docker run -itd --name nginx-hello -p8080:8080 nginx-hello'
      }
    }
    stage("Push a new nginx-hello container") {
      steps {
        sh 'docker tag nginx-hello 10.33.109.104/httpd/nginx-hello'
        sh 'echo $harbor_PSW | docker login 10.33.109.104 -u $harbor_USR --password-stdin'
        sh 'docker push 10.33.109.104/httpd/nginx-hello'
      }
    }
  }
  post {
    always {
      sh 'docker ps'
    }
  }
}

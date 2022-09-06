pipeline {
  agent any
  stages {
    stage("verify tooling") {
      steps {
        sh '''
          docker version
          docker info
          docker build -t nginx-hello .
        '''
      }
    }
  }
  post {
    always {
      sh 'docker rm -f nginx-hello'
      sh 'docker ps'
      sh 'docker run -itd --name nginx-hello -p8080:8080 nginx-hello'
    }
  }
}

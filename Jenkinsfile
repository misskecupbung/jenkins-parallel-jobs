pipeline {
  agent any
  stages {
    stage("verify tooling") {
      steps {
        sh '''
          docker version
          docker info
          ls
          docker build -t .
        '''
      }
    }
  }
  post {
    always {
      sh 'docker ps'
    }
  }
}

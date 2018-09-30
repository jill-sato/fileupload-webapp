pipeline {
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
    preserveStashes()
  }
  agent {
    kubernetes {
      label "${env.label}"
      defaultContainer 'jnlp'
      yaml """
apiVersion: v1
kind: Pod
metadata:
spec:
  containers:
  - name: python-alpine
    image: python:alpine
    args:
    - cat
    tty: true
    imagePullPolicy: Always
#    resources:
#      limits:
#        memory: "8Gi"
#        cpu: "1.75"
"""
    }
  }
  environment {
    FOO = "BAR"
  }
  stages {
    stage('build') {
      agent {
        kubernetes {
          label "${env.label}"
        }
      }
      steps {
        container('python-alpine') {
          sh """
            apk add make bash
            make test
          """
          //archiveArtifacts artifacts: 'bundles/*.zip'
          //stash includes: 'bundles/*', name: 'build-bundles'
        }
      }
    }
  }
}
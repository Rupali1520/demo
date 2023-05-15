pipeline {
    agent any

    stages {
        stage('git clone') {
            steps {
             git branch: 'main', credentialsId: 'newtoken', url: 'https://github.com/Rupali1520/demo.git'
            }
        }
        stage('install packages through ansible'){
            steps{
                sh 'ls'
                sh 'pwd'
                sh 'ansible-playbook install-jenkins.yaml'
            }
        }
        stage("build")
        {
            when{
                branch 'main'
            }
            steps{
                sh 'sudo docker build -t rupali1520/todo:${BUILD_NUMBER} .'
                echo "build success"
            }
        }
        stage('test')
        {
            steps{
                echo 'test ok '
            }
        }
        stage('push image')
        {
             when{
                branch 'main'
            }
            steps{
                withCredentials([string(credentialsId: 'dockerhubpwd', variable: 'docker')]) {
                  sh 'sudo docker login -u rupali1520 -p ${docker}'
                  sh 'sudo docker push rupali1520/todo:${BUILD_NUMBER}'
}
            }
        }
        stage('deploy')
        {
             when{
                branch 'main'
            }
            steps{
                sh 'sudo chmod u+x changetag.sh'
                sh './changetag.sh ${BUILD_NUMBER}'
                //sh 'cat todo_app_deployment.yml'
               withCredentials([file(credentialsId: '66611ddf-d5b2-4c82-8bfe-328903bef7d5', variable: 'kube')]) {
    sh "kubectl --kubeconfig=$kube --validate=false apply -f todo_app_deployment.yml"
}
            }
        }
        
    }
    
    post{
        
        
          
        success{
        
        
          
            mail to: "rupali.gupta@knoldus.com",
        
        
          
            subject: "Build is successfull",
        
        
          
            body: "success"
        
        
          
        }
        
        failure{
        
        
          
      mail to: "rupali.gupta@knoldus.com",
        
        
          
            subject: "Build is failed",
        
        
          
            body: "failed"
        
        
          
    }
        
        
            }
}

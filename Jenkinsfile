pipeline {
    agent any

    stages {
        stage('git clone') {
            steps {
             git branch: 'main', credentialsId: 'newtoken', url: 'https://github.com/Rupali1520/demo.git'
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
            steps{
                sh 'sudo chmod u+x changetag.sh'
                sh './changetag.sh ${BUILD_NUMBER}'
                //sh 'cat todo_app_deployment.yml'
               withCredentials([file(credentialsId: '07280694-d0aa-406c-a1b0-efceab8a44d8', variable: 'var1')])  {
    sh "kubectl --kubeconfig=$var1 --validate=false apply -f todo_app_deployment.yml"
}
            }
        }
        
    }
    post{
        when{
                branch 'main'
            }
        
          
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

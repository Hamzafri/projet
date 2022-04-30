pipeline {
     environment {
       ID_DOCKER = "frikel"
       IMAGE_NAME = "webapp1"
       IMAGE_TAG = "v1"
/*       STAGING = "${ID_DOCKER}-staging"
       PRODUCTION = "${ID_DOCKER}-production"
*/       
       DOCKERHUB_PASSWORD = credentials('dockerhubpassword')
     }
     agent none
     stages {
         stage('Build image') {
             agent any
             steps {
                script {
                  sh 'sudo docker build -t ${ID_DOCKER}/$IMAGE_NAME:$IMAGE_TAG .'
                }
             }
        }
        stage('Run container based on builded image') {
            agent any
            steps {
               script {
                 sh '''
                    docker run --name $IMAGE_NAME -d -p 80:80 -e PORT=80 ${ID_DOCKER}/$IMAGE_NAME:$IMAGE_TAG
                    sleep 5
                 '''
               }
            }
       }
       stage('Test image') {
           agent any
           steps {
              script {
                sh '''
                    curl http://jenkins | grep -i "dimension"
                '''
              }
           }
      }
      stage('Clean Container') {
          agent any
          steps {
             script {
               sh '''
                 docker stop $IMAGE_NAME
                 docker rm $IMAGE_NAME
               '''
             }
          }
     }
     
     stage ('Login and Push Image on docker hub') {
          agent any
          steps {
             script {
               sh '''
                   echo $DOCKERHUB_PASSWORD | docker login -u $ID_DOCKER --password-stdin
                   docker push ${ID_DOCKER}/$IMAGE_NAME:$IMAGE_TAG
               '''
             }
          }
      }     
     
     
     stage('Push image in staging and deploy it') {
       when {
              expression { GIT_BRANCH == 'origin/master' }
            }
      agent any
      steps {
          script {
            sh '''
                echo -e "Déploiement en staging à venir"
            '''
          }
        }
     }
     stage('Push image in production and deploy it') {
       when {
              expression { GIT_BRANCH == 'origin/master' }
            }
      agent any

      steps {
          script {
            sh '''
                echo -e "Déploiement en production à venir"
            '''
          }
        }
     }
  }
}

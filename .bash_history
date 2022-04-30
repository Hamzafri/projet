docker --version
docker ps -a
exit
clear
ip a
docker exec -it jenkins-jenkins-1 cat /var/jenkins_home/secrets/initialAdminPassword
docker ps -a
vi /var/lib/jenkins/secrets/initialAdminPassword
cat /var/lib/jenkins/secrets/initialAdminPassword
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
clear
ip a

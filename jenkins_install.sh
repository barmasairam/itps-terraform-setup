#!/bin/bash 
#Download the java
cd /tmp 
wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm
#install
rpm -ivh jdk-8u131-linux-x64.rpm
#delete the rpm after java installatin
rm -f jdk-8u131-linux-x64.rpm
 
#jenkins installatin
#Enable EPEL
wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
#installing with rpm
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
#update
yum update -y
#install jenkins 
yum install jenkins -y 
#start 
systemctl start jenkins 
#os level service
systemctl enable jenkins 
#check status
systemctl status jenkins

#install maven in /opt
cd /opt
#download the zip
wget https://mirrors.estointernet.in/apache/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.zip
#extract 
unzip apache-maven-3.8.1-bin.zip
#rename
mv apache-maven-3.8.1 maven38
#change the permissions
chmod -R 755 maven38
#delte the zip
rm -f apache-maven-3.8.1-bin.zip

FROM registry.access.redhat.com/openshift3/jenkins-1-rhel7:latest

MAINTAINER Udo Urbantschitsch udo@cloudwerkstatt.com

USER root
RUN echo 7.2 > /etc/yum/vars/releasever
RUN yum -y update \
    && yum -y install java-1.8.0-openjdk-devel git \
    && curl --silent --location https://rpm.nodesource.com/setup_5.x | bash - \
    && yum -y install nodejs bzip2 gcc-c++ make \
    && yum clean all

RUN npm install -g bower grunt-cli

USER 1001 
COPY plugins.txt /opt/openshift/configuration/plugins.txt
RUN /usr/local/bin/plugins.sh /opt/openshift/configuration/plugins.txt

FROM centos:latest

MAINTAINER Udo Urbantschitsch udo@cloudwerkstatt.com

ENV JENKINS_VERSION 1.645
ENV JENKINS_SHA 05fe2369b56e7a2181d3caada805832b3796dc98

ENV JENKINS_UC https://updates.jenkins-ci.org
ENV JENKINS_HOME /var/jenkins_home
ENV JENKINS_SLAVE_AGENT_PORT 50000

RUN yum -y update \
    && yum -y install java-1.8.0-openjdk-devel \
    && mkdir -p /usr/share/jenkins \
    && curl -fL http://mirrors.jenkins-ci.org/war/${JENKINS_VERSION}/jenkins.war -o /usr/share/jenkins/jenkins.war \
    && echo "$JENKINS_SHA /usr/share/jenkins/jenkins.war" | sha1sum -c - \
    && yum clean all

RUN mkdir -p $JENKINS_HOME/plugins \
    && cd $JENKINS_HOME/plugins \
    && curl -sSLO https://updates.jenkins-ci.org/latest/youtrack-plugin.hpi \
    && curl -sSLO https://updates.jenkins-ci.org/latest/gradle.hpi

VOLUME /var/jenkins_home

EXPOSE 8080 50000

CMD java -jar /usr/share/jenkins/jenkins.war

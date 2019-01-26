FROM centos:7
MAINTAINER nmhien889@gmail.com
RUN yum clean all
RUN yum -y update
RUN yum -y install httpd
 
RUN yum install epel-release
RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
RUN yum install php56w-fpm php56w-opcache php56w-common

WORKDIR /myenv
COPY run.sh /myenv
RUN chmod a+x /myenv/*

ENTRYPOINT [ "/myenv/run.sh" ]

EXPOSE 80
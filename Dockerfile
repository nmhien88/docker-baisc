FROM centos:7
MAINTAINER nmhien889@gmail.com
RUN yum clean all
RUN yum -y update
RUN yum -y install httpd
 
RUN yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum install yum-utils
RUN yum-config-manager --enable remi-php56
RUN yum install php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo

WORKDIR /myenv
COPY run.sh /myenv
RUN chmod a+x /myenv/*

ENTRYPOINT [ "/myenv/run.sh" ]

EXPOSE 80
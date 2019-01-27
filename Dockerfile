FROM centos:6
MAINTAINER nmhien889@gmail.com
RUN yum -y install httpd
RUN wget http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
RUN wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
RUN rpm -Uvh epel-release-6-8.noarch.rpm remi-release-6.rpm
RUN yum install yum-utils
RUN yum-config-manager --enable remi-php56
RUN yum install php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo 

WORKDIR /myenv
COPY run.sh /myenv
RUN chmod a+x /myenv/*

ENTRYPOINT [ "/myenv/run.sh" ]

EXPOSE 80
FROM centos:7

# yum install
RUN yum update -y \
 && yum groupinstall -y "Development tools" \
 && yum install -y \
            cmake \
            curl \
            gcc \
            make \
            sudo \
            tmux \
            unzip \
            vim \
            wget \
 && rm -rf /var/cache/yum/* \
 && yum clean all

# git install
RUN yum remove -y git \
 && yum install -y https://centos7.iuscommunity.org/ius-release.rpm \
 && yum install -y \
            libsecret \
            pcre2 \
 && yum install -y git --enablerepo=ius --disablerepo=base,epel,extras,updates \
 && rm -rf /var/cache/yum/* \
 && yum clean all

# Japanese Locale Setting
RUN localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LANG="ja_JP.UTF-8" \
    LANGUAGE="ja_JP:ja" \
    LC_ALL="ja_JP.UTF-8"

# alias
RUN echo "alias ll='ls -lahF --color=auto'" >> ~/.bashrc

# work directory
WORKDIR /share

CMD ["/sbin/init"]

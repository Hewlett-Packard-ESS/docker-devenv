FROM hpess/base:latest
MAINTAINER Karl Stoney <karl.stoney@hp.com>

# Install Git and Ruby
RUN yum -y install vim git-core ruby rubygems ruby-devel make rubygem-nokogiri gcc && \
    yum -y clean all

# Configure some ruby bits
ADD .gemrc ~/.gemrc
RUN gem install albacore json net-ssh net-scp bcrypt bundler

# Install nvm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.20.0/install.sh | bash
RUN source ~/.nvm/nvm.sh && nvm install 0.10

# Configure some node bits
RUN source ~/.bashrc && nvm use 0.10 && npm install -g grunt-cli jake

# Configure some other bits
ADD .vimrc ~/.vimrc

# Add the Entrypoint
ADD devenv.sh /usr/bin/devenv.sh
ENTRYPOINT ["/usr/bin/devenv.sh"]

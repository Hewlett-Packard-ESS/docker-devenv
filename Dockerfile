FROM hpess/base:latest
MAINTAINER Karl Stoney <karl.stoney@hp.com>

# Install NodeJS
RUN wget -q http://nodejs.org/dist/v0.10.33/node-v0.10.33-linux-x64.tar.gz && \
  tar xf node-v0.10.33-linux-x64.tar.gz \
  --strip-components=1 --no-same-owner \
  -C /usr/local \
  node-v0.10.33-linux-x64/bin \
  node-v0.10.33-linux-x64/lib \
  node-v0.10.33-linux-x64/share

# Install Git and Ruby
RUN yum -y install git-core ruby rubygems ruby-devel make rubygem-nokogiri gcc && \
    yum -y clean all

# Configure some npm bits
RUN npm install -g grunt-cli
RUN npm install -g jake

# Configure some ruby bits
ADD .gemrc /root/.gemrc
RUN gem install albacore json net-ssh net-scp bcrypt bundler

# Add the Entrypoint
ADD devenv.sh /usr/bin/devenv.sh
CMD ["/usr/bin/devenv.sh"]

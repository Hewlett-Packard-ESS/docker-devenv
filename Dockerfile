FROM hpess/base:latest
MAINTAINER Karl Stoney <karl.stoney@hp.com>

# Install core development tools 
RUN yum -y install vim git-core build-essential tmux openssh-server && \
    yum -y clean all

# Configure sshd and wemux
RUN mkdir /var/run/sshd && \
    ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key && \
    useradd devenv -G wheel && \
    echo 'root:password' | chpasswd && \
    echo 'devenv:devenv' | chpasswd && \
    echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers && \
    mkdir -p /home/devenv/.ssh && \ 
    chown -R devenv:devenv /home/devenv/.ssh && \
    chmod 700 /home/devenv/.ssh
 
# Install Wemux 
RUN git clone git://github.com/zolrath/wemux.git /usr/local/share/wemux && \
    ln -s /usr/local/share/wemux/wemux /usr/local/bin/wemux && \
    cp /usr/local/share/wemux/wemux.conf.example /usr/local/etc/wemux.conf
ADD wemux.conf /usr/local/etc/wemux.conf

# Configure some other bits
ADD .vimrc ~/.vimrc

# Add the sshd service
ADD sshd.service.conf /etc/supervisord.d/sshd.service.conf
RUN echo "ForceCommand /usr/bin/devenv.sh" >> /etc/ssh/sshd_config
EXPOSE 22

# Add the Entrypoint
ADD devenv.sh /usr/bin/devenv.sh
ENTRYPOINT ["/usr/bin/devenv.sh"]

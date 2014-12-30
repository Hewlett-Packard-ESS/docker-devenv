FROM hpess/base:latest
MAINTAINER Karl Stoney <karl.stoney@hp.com>

# Install core development tools 
RUN yum -y install vim git-core build-essential tmux openssh-server gcc-c++ gcc make && \
    yum -y clean all

# Install Wemux 
RUN git clone --depth=1 https://github.com/zolrath/wemux.git /usr/local/share/wemux && \
    ln -s /usr/local/share/wemux/wemux /usr/local/bin/wemux

# Create our devenv and wemux users
RUN useradd devenv -G wheel && \
    useradd wemux

# Clone the vim stuff
RUN mkdir -p /home/devenv/.vim/vim-addons && \
    cd /home/devenv/.vim/vim-addons && \
    git clone --depth=1 https://github.com/MarcWeber/vim-addon-manager && \
    git clone --depth=1 https://github.com/tpope/vim-fugitive fugitive && \
    git clone --depth=1 https://github.com/airblade/vim-gitgutter github-airblade-vim-gitgutter && \
    git clone --depth=1 https://github.com/editorconfig/editorconfig-vim github-editorconfig-editorconfig-vim && \
    git clone --depth=1 https://github.com/geekjuice/vim-spec github-geekjuice-vim-spec && \
    git clone --depth=1 https://github.com/nanotech/jellybeans.vim jellybeans && \
    git clone --depth=1 https://github.com/tomasr/molokai.git && \
    git clone --depth=1 https://github.com/sickill/vim-monokai github-sickill-vim-monokai && \
    git clone --depth=1 https://github.com/Lokaltog/powerline && \
    git clone --depth=1 https://github.com/garbas/vim-snipmate snipmate && \
    git clone --depth=1 https://github.com/majutsushi/tagbar Tagbar && \
    git clone --depth=1 https://github.com/scrooloose/nerdtree The_NERD_tree && \
    git clone --depth=1 https://github.com/tomtom/tlib_vim tlib && \
    git clone --depth=1 https://github.com/MarcWeber/vim-addon-commenting && \
    git clone --depth=1 https://github.com/MarcWeber/vim-addon-mw-utils && \
    git clone --depth=1 https://github.com/Chiel92/vim-autoformat && \
    git clone --depth=1 https://bitbucket.org/vimcommunity/vim-pi && \
    git clone --depth=1 https://github.com/honza/vim-snippets && \
    git clone --depth=1 https://github.com/kristijanhusak/vim-multiple-cursors github-kristijanhusak-vim-multiple-cursors && \
    git clone --depth=1 http://github.com/digitaltoad/vim-jade github-digitaltoad-vim-jade && \
    git clone --depth=1 http://github.com/tpope/vim-cucumber github-tpope-vim-cucumber && \
    mkdir -p /home/devenv/.vim/vim-addons/matchit.zip/archive/ && \
    curl --silent -L --max-redirs 40 -o '/home/devenv/.vim/vim-addons/matchit.zip/archive/matchit.zip' 'http://www.vim.org/scripts/download_script.php?src_id=8196'

# Make SSH listen on a non standard port
RUN echo 'Port 2022' >> /etc/ssh/sshd_config
EXPOSE 2022

# Setup sshd
RUN mkdir -p /var/run/sshd && \
    ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key && \
    echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# Copy over configurations, services etc.
COPY wemux.conf /usr/local/etc/wemux.conf
COPY preboot/* /preboot/
COPY services/* /etc/supervisord.d/
COPY home/* /home/devenv/

# Fix any permissions
RUN mkdir -p /home/devenv/.ssh && \ 
    chown -R devenv:devenv /home/devenv && \
    chmod 700 /home/devenv/.ssh

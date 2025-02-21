FROM ubuntu:24.04

RUN apt-get update && apt-get upgrade -y

RUN apt-get -y install git ninja-build gettext cmake unzip curl xsel nodejs npm python3-venv

RUN apt-get -y install sudo 

# Install Neovim
RUN git clone https://github.com/neovim/neovim \
    && cd neovim \
    && make CMAKE_BUILD_TYPE=RelWithDebInfo \
    && make install

# Add yohi user 
ARG USERNAME=yohi
ARG GROUPNAME=yohi
ARG UID=1000
ARG GID=1000

RUN useradd -m -s /bin/bash ${USERNAME} && echo "${USERNAME}:password" | chpasswd && usermod -aG sudo ${USERNAME}

WORKDIR /home/$USERNAME/

# Install Homebrew
RUN useradd -m -s /bin/zsh linuxbrew && \
    usermod -aG sudo linuxbrew &&  \
    mkdir -p /home/linuxbrew/.linuxbrew && \
    chown -R linuxbrew: /home/linuxbrew/.linuxbrew
USER linuxbrew
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Change to yohi user
USER $USERNAME


# WORKDIR /neovim
# 
# RUN npm install tree-sitter-cli

# # RUN git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
# # RUN git clone -b feature/basedpyright https://github.com/yohi/dotfiles.git ~/dotfiles
# # 
# # RUN cd ~/dotfiles
# # RUN $(mkdir -p ~/.config)
# # RUN ln -nfs ~/dotfiles/vim ~/.vim
# # RUN ln -nfs ~/dotfiles/vim/rc/vimrc ~/.vimrc
# # RUN ln -nfs ~/dotfiles/vim/rc/gvimrc ~/.gvimrc
# # RUN ln -nfs ~/dotfiles/vim ~/.config/nvim
# # RUN ln -nfs ~/dotfiles/vim/rc/vimrc ~/.config/nvim/init.vim
# # RUN ln -nfs ~/dotfiles/cspell ~/.config/cspell
# # RUN ln -nfs ~/dotfiles/vim/denops_translate ~/.config/denops_translate
# 
# # RUN echo 'export DENO_INSTALL="/root/.deno"' >> ~/.bashrc
# # RUN echo 'export PATH="$DENO_INSTALL/bin:$PATH"' >> ~/.bashrc
# # 
# # # RUN bash
# # 
# # RUN curl -fsSL https://deno.land/install.sh | sh
# # 
# # RUN echo 'export DENO_INSTALL="/root/.deno"' >> ~/.bashrc \
# #   && echo 'export PATH="$DENO_INSTALL/bin:$PATH"' >> ~/.bashrc
# # 
# # ENV PATH "$HOME/.deno/bin:$PATH"
# # 
# # 
# # RUN bash -c "nvim --headless +\"call dpp#async_ext_action('installer', 'update')\" +qa"
# # 
# # # CMD ["env", "PATH=$HOME/.deno/bin:$PATH", "/usr/local/bin/nvim"]
# # CMD ["bash", "-c", "nvim"]
# # # CMD nvim
# 
# 
# WORKDIR /root
# 
# RUN curl -fsSL https://deno.land/install.sh | sh
# 
# 
# # Denoのパスを環境変数に追加
# ENV DENO_INSTALL=/root/.deno
# ENV PATH="$DENO_INSTALL/bin:$PATH"
# 
# RUN nvim --headless +qall
# RUN nvim --headless +"call dpp#async_ext_action('installer', 'update')" +qall
# 
# CMD ["nvim"]
CMD ["bash"]

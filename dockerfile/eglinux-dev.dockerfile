FROM ubuntu:noble

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai
ENV USER=eg
ENV HOME=/home/$USER

# Install base packages and development tools
RUN apt-get update && apt-get install -y \
    # Basic system tools
    curl \
    wget \
    git \
    vim \
    tmux \
    zsh \
    sudo \
    # Build tools
    build-essential \
    ninja-build \
    pkg-config \
    # Programming languages and runtimes
    python3 \
    python3-pip \
    python3-venv \
    nodejs \
    npm \
    # System libraries and tools
    ca-certificates \
    gnupg \
    lsb-release \
    software-properties-common \
    apt-transport-https \
    # Network and debugging tools
    net-tools \
    iputils-ping \
    tcpdump \
    strace \
    gdb \
    valgrind \
    # Text processing tools
    ripgrep \
    fd-find \
    fzf \
    jq \
    # Other useful tools
    tree \
    htop \
    unzip \
    zip \
    && rm -rf /var/lib/apt/lists/*

# Create user eg
RUN groupadd -r $USER && \
    useradd -r -g $USER -d $HOME -s /bin/zsh -c "Development User" $USER && \
    mkdir -p $HOME && \
    chown -R $USER:$USER $HOME && \
    echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to eg user
USER $USER
WORKDIR $HOME

# Install Oh My Zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Configure Oh My Zsh theme to bira
RUN sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="bira"/' $HOME/.zshrc

# Install Homebrew
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.zshrc && \
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.bashrc

# Add Homebrew to PATH for current session and install common tools
ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && \
    brew install nvim

# Configure Git user info (can be overridden at runtime)
RUN git config --global user.name "Eglinux" && \
    git config --global user.email "mthreads0755@gmail.com" && \
    git config --global core.editor nvim

# Set zsh as default shell
ENV SHELL=/bin/zsh

# Set working directory
WORKDIR $HOME

# Default to zsh
CMD ["/bin/zsh"]

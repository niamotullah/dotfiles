# Usage

- clone with all submodules

  ```bash
  export DOTFILES=$HOME/.dotfiles
  git clone --recurse-submodules https://github.com/niamotullah/dotfiles.git $DOTFILES
  ```

- deploy from cloned directory

  ```bash
  cd $HOME/.dotfiles
  ./deploy.sh
  ```

- make sure to install and change the default shell of the current user

  ```bash
  apt install zsh -y
  chsh -s $(which zsh) $USER
  ```

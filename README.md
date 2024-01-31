# Dotfiles

To copy ~/.zshrc to dotfiles/.zshrc you can run:
```bash
chmod +x ./sync-zshrc.sh
./sync-zshrc
```

## Scripts
These install / setup scripts should work on linux and macOS, but so far I have only tested them in linux.

### Make all scripts executable
```bash
chmod +x ./scripts/*.{sh,zsh}
```

### Install Zsh and set as current shell
```bash
./scripts/install_zsh.sh
```

#### Verify shell has updated to zsh:
```bash
echo $SHELL
```

### To automatically run all following scripts at once:
```bash
./scripts/run_all.zsh
```

### Setup new system
```bash
./scripts/setup_new_system.sh
```
This `setup_new_system.sh` script installs and sets up the following:
- Node.js with fnm [Fast Node Manager](https://github.com/Schniz/fnm)
- lazygit
- pnpm
- cookie-ai-cli
- Docker Engine


### Install Go
```bash
./scripts/install_go.sh
```

### Install Python
```bash
./scripts/install_python.sh
```

### Install fd
```bash
./scripts/install_fd.sh
```

### Install tree
```bash
./scripts/install_tree.sh
```

### Install viu (and Rust/Cargo if necessary)
```bash
./scripts/install_viu.sh
```
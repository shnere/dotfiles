# dotfiles

Fish, Ghostty, Karabiner (Caps Lock as Hyper), Cursor, git, Homebrew, macOS defaults.

## New machine

```sh
git clone git@github.com:shnere/dotfiles.git
cd dotfiles
./install.sh          # symlinks, brew bundle, fish as shell, fisher
./install.sh --work   # same, plus Brewfile.work
./.macos              # system defaults, hot corners, shortcuts
```

Then by hand:

- Raycast: Settings > Advanced > Import your `.rayconfig`.
- Cursor: sign in and let Settings Sync restore extensions. No access? Fall back to
  `xargs -n1 cursor --install-extension < cursor/extensions.txt`.
- GPG and SSH keys: import or generate, then update `signingkey` if new.

## Machine-specific config

Kept outside the repo, sourced if present:

- `~/.config/work.fish`: work paths, aliases, secrets.
- `~/.gitconfig.local`: work email and signing key.

## Layout

Configs are symlinked from here into place, so edit them anywhere and commit.
`install.sh` backs up anything it replaces as `*.bak`.

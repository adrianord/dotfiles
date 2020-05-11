# dotfiles
Ansible configured dotfiles

Clone repo `git clone https://github.com/adrianord/dotfiles ~/.dotfiles`

Create file `~/.dotfile` with user specific data
```
work_companies:
  - name: work
    git_email: work@work.com

username: jdoe

full_name: John Doe
git_user: jdoe
git_email: JohnDoe@email.com
```

Run `~/.dotfiles/bin/bootstrap`

# dotfiles
Ansible configured dotfiles

Clone repo `git clone https://github.com/adrianord/dotfiles "${XDG_DATA_HOME:-${HOME}/.config}/dotfiles/playbook"`

Create file `${XDG_DATA_HOME:-${HOME}/.config}/dotfiles/config` with user specific data
```yaml
work_companies:
  - name: work
    git_email: work@work.com

username: jdoe

full_name: John Doe
git_user: jdoe
git_email: JohnDoe@email.com
```

Run `${XDG_DATA_HOME:-${HOME}/.config/dotfiles}/playbook/bin/bootstrap`

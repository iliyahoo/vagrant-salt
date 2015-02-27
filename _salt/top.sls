base:
  '*':
    - myuser.user
    - myuser.dotfiles
  'os_family:redhat':
    - match: grain
    - users_and_ssh

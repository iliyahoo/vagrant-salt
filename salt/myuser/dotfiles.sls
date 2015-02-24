include:
  - myuser.user
install_git:
  pkg.installed:
    - name: git
clone_dotfiles:
  git.latest:
    - name: git://github.com/basepi/dotfiles.git
    - rev: master
    - target: /home/basepi/dotfiles
    - user: basepi
    - submodules: True
    - require:
      - pkg: install_git
      - user: add_user_basepi
install_dotfiles_if_changed:
  cmd.run:
    - name: 'python install.py -y'
    - cwd: '/home/basepi/dotfiles'
    - user: basepi
    - onchanges:
      - git: clone_dotfiles

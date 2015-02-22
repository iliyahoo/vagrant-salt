install_zsh:
  pkg.installed:
    - name: zsh
add_user_basepi:
  user.present:
    - name: basepi
    - shell: /bin/zsh
    - require:
      - pkg: install_zsh

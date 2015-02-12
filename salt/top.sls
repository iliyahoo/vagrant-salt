base:
  '*':
    - default
  'roles:webserver':
    - match: grain
  minion-1:
    - webserver
#    - default.no-pkgs
#    - default.no-jane

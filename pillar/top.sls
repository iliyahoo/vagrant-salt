base:
  '*':
    - core
  'os_family:RedHat':
    - match: grain
    - ssh_key

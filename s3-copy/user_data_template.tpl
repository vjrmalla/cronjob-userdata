#cloud-config


groups:
  - infraopsmi

users:
  - default
  - name: opsmicopy
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    groups: infraopsmi
    shell: /bin/bash

write_files:
-   owner: root:root
    path: /tmp/s3copy.sh
    permissions: '0754'
    content: |
        ${script_content}

-   owner: root:root
    path: "/etc/crontab"
    content: |
        "*/5 * * * * root /tmp/s3copy.sh\n"
    append: true
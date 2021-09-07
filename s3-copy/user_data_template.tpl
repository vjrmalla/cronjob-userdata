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
        #!/bin/bash
        echo "cron job running" >> /tmp/s3copy.log 2>&1

-   owner: root:root
    path: "/etc/crontab"
    content: "*/5 * * * * root /tmp/s3copy.sh"
    append: true
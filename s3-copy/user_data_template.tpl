#cloud-config


groups:
  - infraopsmi

users:
  - default
  - name: opsmicopy
<<<<<<< HEAD
=======
    ssh-authorized-keys:
>>>>>>> 6cd7347244aa8a462020a05a52e005cb867107a2
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    groups: infraopsmi
    shell: /bin/bash

write_files:
-   owner: root:root
<<<<<<< HEAD
    path: /tmp/s3copy.sh
    permissions: '0754'
    content: |
        #!/bin/bash
        echo "cron job running" >> /tmp/s3copy.log 2>&1

-   owner: root:root
    path: "/etc/crontab"
    content: "*/5 * * * * root /tmp/s3copy.sh"
    append: true
=======
    path: /tmp/s3copy1.sh
    permissions: '0644'
    content: |
        ENVIRONMENT="${environment}"
        PLATFORM="${platform}"

-   owner: root:root
    path: /tmp/s3copy2.sh
    permissions: '0640'
    content: |
          PLATFORM="${platform}"
          ENVIRONMENT="${environment}"
>>>>>>> 6cd7347244aa8a462020a05a52e005cb867107a2

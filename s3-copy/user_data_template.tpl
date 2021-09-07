#cloud-config


groups:
  - infraopsmi

users:
  - default
  - name: opsmicopy
    ssh-authorized-keys:
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    groups: infraopsmi
    shell: /bin/bash

write_files:
-   owner: root:root
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

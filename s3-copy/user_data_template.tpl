#cloud-config

write_files:
-   owner: root:root
    path: /tmp/s3copy.sh
    permissions: '0754'
    encoding = "b64"
    content: file("$${path.module}/s3copy.sh")
-   owner: root:root
    path: /etc/cron.d/s3copy_cron
    permissions: '0644'
    content: "*/5 * * * * root /tmp/s3copy.sh"

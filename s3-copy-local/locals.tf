locals {
  instance_user_data = {
  "groups": [
    "infraopsmi"
  ],
  "users": [
    "default",
    {
      "name": "opsmicopy",
      "sudo": [
        "ALL=(ALL) NOPASSWD:ALL"
      ],
      "groups": "infraopsmi",
      "shell": "/bin/bash"
    }
  ],
  "write_files": [
    {
      "owner": "root:root",
      "path": "/tmp/s3copy.sh",
      "permissions": "0754",
      "encoding" = "b64",
      "content": filebase64("${path.module}/s3copy.sh")
    },
    {
      "owner": "root:root",
      "path": "/etc/cron.d/s3copy_cron",
      "permissions": "0644",
      "content": "*/5 * * * * root /bin/bash /tmp/s3copy.sh"
    }
  ]
}
}

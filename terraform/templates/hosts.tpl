[server]
jenkins ansible_host=${jenkins_ip}

[workers]
staging ansible_host=${staging_ip}
production ansible_host=${production_ip}

[all:vars]
ansible_user=ubuntu
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
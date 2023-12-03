ansible-playbook -i hosts github.yaml -u ubuntu --vault-password-file /path/to/your/ansible/vars/vault_pass.txt
# Meaningful list of files
- k8s-master: Set up master host
- k8s-worker: Set up worker host
- k8s-base: Grant users permission to use the cluster
- app-install: Install django web to master
- app-configure: Configuration for application
- cert: Reach certificate for domain
- nginx-install: Install Nginx
- prometheus: Install and set up prometheus
- github: clone repository

# HEAT
Cluster management

## Requirements
### Main (Management)
- Download Ansible `curl -o resources/scripts/installers/ansible/ansible-2.3.0.0-1.tar.gz https://github.com/ansible/ansible/archive/v2.3.0.0-1.tar.gz`
    - (It can't be directly included in this package because of its license...)
- Internet connection
- [Docker (Tested with 17.03)](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/install/)

### Cluster nodes
- Tested with Ubuntu 16.04

## Production
Following soon...

## Development
There is a development environment defined in `docker-compose.override.yml`

# Notes
- Hint: sudo -i to run ansible
- Add custom debug iframe in console
- dev domains using [xip](xip.io)
- Firewall: ufw and fail2ban?
- Certificates using self signed or [Certbot](https://certbot.eff.org/#debianjessie-other)
    - `sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./data/ssl/nginx.key -out ./data/ssl/nginx.crt`

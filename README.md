# HEAT
Cluster management

## Requirements
### Main (Management)
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
- Add custom debug iframe in console
- dev domains using [xip](xip.io)
- Firewall: ufw and fail2ban?
- Certificates using self signed or [Certbot](https://certbot.eff.org/#debianjessie-other)
    - `sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./data/ssl/nginx.key -out ./data/ssl/nginx.crt`

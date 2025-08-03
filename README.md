# n8n Docker Setup with SSL

This setup provides n8n with PostgreSQL database, NGINX reverse proxy, and SSL certificates using mkcert.

## Prerequisites

- Docker and Docker Compose
- mkcert (will be installed by setup script if not present)

## Quick Start

1. Clone or download all files to a directory
2. Run the setup script:
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```
3. Start the services:
   ```bash
   docker-compose up -d
   ```
4. Access n8n at: https://localhost

## Services

- **n8n**: Workflow automation tool (port 5678 internally)
- **PostgreSQL**: Database for n8n data
- **NGINX**: Reverse proxy with SSL termination (ports 80, 443)

## SSL Certificates

The setup uses mkcert to generate locally-trusted certificates for development. The certificates are automatically generated for:
- localhost
- 127.0.0.1
- ::1 (IPv6 localhost)

## Configuration

- Modify `docker-compose.yml` for service configuration
- Update `nginx/nginx.conf` for NGINX settings
- Change `.env` file for environment variables

## Commands

```bash
# Start services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down

# Rebuild and restart
docker-compose down && docker-compose up -d --build

# Access n8n container
docker exec -it n8n /bin/sh
```

## Troubleshooting

1. **Certificate issues**: Run `mkcert -install` to install the local CA
2. **Port conflicts**: Change ports in docker-compose.yml if 80/443 are in use
3. **Database connection**: Check if PostgreSQL container is running with `docker-compose ps`

## Production Notes

For production deployment:
1. Replace mkcert certificates with proper SSL certificates
2. Update server_name in nginx.conf to your domain
3. Set strong passwords in .env file
4. Configure proper backup for PostgreSQL data
5. Set up proper logging and monitoring
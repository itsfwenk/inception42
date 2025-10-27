# Inception42

A comprehensive Docker-based web infrastructure project featuring WordPress, MariaDB, Nginx, Redis, FTP, Adminer, and Portainer services.

## 📋 Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Services](#services)
- [File Structure](#file-structure)
- [Configuration](#configuration)
- [Development](#development)
- [Troubleshooting](#troubleshooting)

## 🎯 Overview

Inception42 is a containerized web infrastructure project that demonstrates the deployment and orchestration of multiple services using Docker and Docker Compose. The project includes a complete web stack with WordPress as the content management system, backed by MariaDB database, served through Nginx with SSL/TLS encryption, and enhanced with additional services for development and administration.

## 🏗️ Architecture

The project consists of the following interconnected services:

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│    Nginx    │    │  WordPress  │    │   MariaDB   │
│   (HTTPS)   │◄──►│    (PHP)    │◄──►│ (Database)  │
│   Port 443  │    │   Port 9000 │    │   Port 3306 │
└─────────────┘    └─────────────┘    └─────────────┘
       ▲                  ▲                    ▲
       │                  │                    │
       ▼                  ▼                    ▼
┌─────────────────────────────────────────────────────┐
│                Inception Network                    │
└─────────────────────────────────────────────────────┘
       ▲                  ▲                    ▲
       │                  │                    │
       ▼                  ▼                    ▼
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│    Redis    │    │   Adminer   │    │  Portainer  │
│   (Cache)   │    │  (DB Admin) │    │ (Container  │
│             │    │             │    │   Mgmt)     │
└─────────────┘    └─────────────┘    └─────────────┘
       ▲
       │
       ▼
┌─────────────┐
│     FTP     │
│   Server    │
│ Ports 20-21 │
└─────────────┘
```

## ✅ Prerequisites

- Docker Engine (v20.10+)
- Docker Compose (v2.0+)
- Make utility
- Linux/Unix environment
- At least 2GB RAM available
- At least 5GB disk space

## 🚀 Installation

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd inception42
   ```

2. **Set up environment variables:**
   ```bash
   # Create .env file in srcs/ directory
   cp srcs/.env.example srcs/.env
   # Edit the .env file with your configuration
   ```

3. **Create required directories:**
   ```bash
   mkdir -p ~/data/wordpress
   mkdir -p ~/data/mariadb
   ```

4. **Build and start the services:**
   ```bash
   make all
   ```

## 🎮 Usage

### Basic Commands

- **Start all services:**
  ```bash
  make all
  ```

- **Start services in detached mode:**
  ```bash
  make detach
  ```

- **Stop services:**
  ```bash
  make stop
  ```

- **Stop and remove containers:**
  ```bash
  make down
  ```

- **Rebuild all containers:**
  ```bash
  make rebuild
  ```

- **Clean up Docker system:**
  ```bash
  make clean
  ```

- **Full cleanup and restart:**
  ```bash
  make re
  ```

### Accessing Services

Once the services are running, you can access:

- **WordPress Site:** `https://fli.42.fr` (port 443)
- **WordPress Admin:** `https://fli.42.fr/wp-admin`
- **Adminer (Database Admin):** Access through Nginx reverse proxy
- **FTP Server:** `ftp://fli.42.fr` (ports 20, 21, 30000-30100)

## 🛠️ Services

### Nginx
- **Purpose:** Web server and reverse proxy
- **Features:** SSL/TLS encryption, static file serving, PHP-FPM integration
- **Configuration:** `srcs/requirements/nginx/conf/nginx.conf`

### WordPress
- **Purpose:** Content Management System
- **Features:** PHP-FPM, Redis caching integration
- **Database:** MariaDB
- **Volume:** Persistent storage in `~/data/wordpress`

### MariaDB
- **Purpose:** MySQL-compatible database server
- **Features:** Persistent data storage, optimized configuration
- **Volume:** Persistent storage in `~/data/mariadb`
- **Configuration:** `srcs/requirements/mariadb/conf/50-server.cnf`

### Redis
- **Purpose:** In-memory cache and session storage
- **Features:** WordPress object caching, session management

### FTP Server
- **Purpose:** File transfer protocol server
- **Features:** Secure file uploads, WordPress file management
- **Ports:** 20, 21, 30000-30100 (passive mode)

### Adminer
- **Purpose:** Web-based database administration
- **Features:** MySQL/MariaDB management interface

### Portainer
- **Purpose:** Docker container management
- **Features:** Web-based Docker administration interface

## 📁 File Structure

```
inception42/
├── Makefile                          # Build automation
├── README.md                         # This file
├── srcs/
│   ├── docker-compose.yml           # Service orchestration
│   ├── .env                         # Environment variables
│   └── requirements/                # Service configurations
│       ├── nginx/
│       │   ├── Dockerfile
│       │   ├── conf/nginx.conf
│       │   └── website-files/
│       ├── wordpress/
│       │   ├── Dockerfile
│       │   └── wp_script.sh
│       ├── mariadb/
│       │   ├── Dockerfile
│       │   ├── docker-entrypoint.sh
│       │   └── conf/50-server.cnf
│       ├── redis/
│       │   └── Dockerfile
│       ├── ftp/
│       │   ├── Dockerfile
│       │   └── vsftpd.conf
│       ├── adminer/
│       │   ├── Dockerfile
│       │   └── adminer-script.sh
│       └── portainer/
│           └── Dockerfile
└── poubelle/                        # Development files
    └── website/                     # Static website (Vite/TypeScript)
```

## ⚙️ Configuration

### Environment Variables

Create a `.env` file in the `srcs/` directory with the following variables:

```bash
# Database Configuration
MYSQL_ROOT_PASSWORD=your_root_password
MYSQL_DATABASE=wordpress
MYSQL_USER=wordpress_user
MYSQL_PASSWORD=your_mysql_password

# WordPress Configuration
WORDPRESS_DB_HOST=mariadb:3306
WORDPRESS_DB_NAME=wordpress
WORDPRESS_DB_USER=wordpress_user
WORDPRESS_DB_PASSWORD=your_mysql_password

# FTP Configuration
FTP_USER=ftp_user
FTP_PASSWORD=your_ftp_password

# Domain Configuration
DOMAIN_NAME=fli.42.fr
```

### SSL Certificates

The project uses self-signed SSL certificates. For production use, replace with proper certificates:

```bash
# Location: srcs/requirements/nginx/ssl/
inception.crt  # SSL certificate
inception.key  # Private key
```

## 💻 Development

### Static Website Development

The project includes a Vite-based TypeScript development environment in `poubelle/website/`:

```bash
cd poubelle/website
npm install
npm run dev      # Development server
npm run build    # Production build
```

### Adding New Services

1. Create a new directory in `srcs/requirements/`
2. Add Dockerfile and configuration files
3. Update `docker-compose.yml`
4. Add necessary environment variables
5. Update Makefile if needed

## 🔧 Troubleshooting

### Common Issues

1. **Port conflicts:**
   - Ensure ports 443, 20, 21, and 30000-30100 are available
   - Stop conflicting services: `sudo systemctl stop apache2 nginx`

2. **Permission issues:**
   - Ensure Docker daemon is running
   - Add user to docker group: `sudo usermod -aG docker $USER`

3. **SSL certificate errors:**
   - Accept self-signed certificate in browser
   - Or generate new certificates

4. **Database connection issues:**
   - Check MariaDB container logs: `docker logs mariadb`
   - Verify environment variables in `.env`

5. **WordPress setup issues:**
   - Access WordPress through HTTPS only
   - Complete installation wizard on first access

### Logs and Debugging

```bash
# View all container logs
docker-compose -f srcs/docker-compose.yml logs

# View specific service logs
docker logs nginx
docker logs wordpress
docker logs mariadb

# Monitor real-time logs
docker-compose -f srcs/docker-compose.yml logs -f
```

### Useful Commands

```bash
# Enter a running container
docker exec -it nginx /bin/bash
docker exec -it wordpress /bin/bash

# Check container status
docker-compose -f srcs/docker-compose.yml ps

# Restart specific service
docker-compose -f srcs/docker-compose.yml restart nginx
```

## 📝 Notes

- This project is designed for educational purposes and local development
- For production deployment, additional security measures should be implemented
- Regular backups of the MariaDB and WordPress volumes are recommended
- Monitor disk space usage in `~/data/` directories

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📄 License

This project is for educational purposes. Please refer to your institution's guidelines for usage and distribution.

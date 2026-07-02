# 🛠️ Developer Documentation

## 📖 Overview

This project uses Docker to orchestrate multiple services:
- Nginx (web server)
- WordPress (PHP-FPM)
- MariaDB (database)

Each service is defined in its own Dockerfile and built through Docker Compose.

---

## ⚙️ Prerequisites

- Docker
- Docker Compose
- Make
- Linux environment (recommended)

---

## 📁 Project Setup

### 1. Clone the repository

```bash
git clone <repo_url>
cd inception
```

### 2.Configure Domain
Edit `/etc/hosts`.
```bash
sudo nano /etc/hosts
```
Add `127.0.0.1 arocca.42.fr`

### 3. Setup secrets
Create required files inside secrets/:
```
secrets/credentials.txt
secrets/db_user.txt
secrets/db_password.txt
secrets/db_root_password.txt
```

**⚠️ credentials.txt must contain user=, admin= for users and user_pswd=, admin_pswd= for passwords. The other files just contains a single line corresponding to the data itself.**

## 🏗️ Build and Launch
### Using Makefile
```bash
make up
```

Other Makefile commands:
- **build**: build the images
- **up**: build the images and launches the containers
- **down**: stops the containers
- **clean**: removes containers and volumes
- **fclean**: removes containers, volumes, images, cache, local data...
- **logs**: launches with `logs -f`
- **ps**: launches `docker ps`
- **restart**: restarts the containers

### Using docker compose
```bash
cd srcs
sudo docker compose up --build
```

## 🧰 Useful Commands
### 📦 Containers
```bash
docker ps
docker stop <container>
docker start <container>
docker restart <container>
```

### 📜 Logs
```bash
docker-compose logs
docker logs <container>
```

### 🧹 Cleanup
```bash
make clean
make fclean
```
or
```bash
sudo docker compose down -v
```

## 💾 Data Persistence
Data is stored using Docker volumes.

Persistent data:

- MariaDB database files
- WordPress files

Volumes ensure that data remains even after containers are stopped or removed.
The data is stored inside `home/arocca/data/` folder. You can see its configuration in the `volumes` section of the `srcs/docker-compose.yml` file.

## 📂 Project Structure
```
srcs/  
 ├── requirements/  
 │    ├── nginx/  
 │    ├── mariadb/  
 │    └── wordpress/
 ├── .env  
 └── docker-compose.yml
```
Each service directory contains:
- a Dockerfile to build its image
- a .dockerignore to control what is sent to Docker
- a `tools/` directory that contains the service init script

Nginx service also contains a `conf/` directory to store a config file.


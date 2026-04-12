*This project has been created as part of the 42 curriculum by arocca.*

# __**🪆 INCEPTION 🪆**__

## 📖 Description
This project aims to introduce containerization using Docker.  
The goal is to build a complete infrastructure by setting up several interconnected services each inside their own container.  

The architecture is composed of:
- a web server using Nginx
- a Wordpress application
- an MariaDB database

The project imposes the use of docker networking, a data persistence and secure management of credentials and sensitive information.
</br>

## 📜 Instructions
### ⛲️ Requirements:
- Docker
- Docker compose
- root or sudo access
### ⬇️ Installation:
- Clone the repository:
    ```sh
    git clone <repo_url> inception
    cd inception
    ```
- Configure the local domain:
  ```sh
  sudo nano /etc/hosts
  ```
  - then add `127.0.0.1 arocca.42.fr` after the other hosts
### 📣 Launching project:
Here are the commands you can use:
- **build**: build the images
- **up**: build the images and launches the containers
- **down**: stops the containers
- **clean**: removes containers and volumes
- **fclean**: removes containers, volumes, images, cache, local data...
- **logs**: launches with `logs -f`
- **ps**: launches `docker ps`
- **restart**: restarts the containers
### Access to the web app:
Open your browser and go to `https://arocca.42.fr`
</br>

## 📦 Project Description
### ℹ️ Use of Docker
Docker allows applications to run inside isolated environments called containers.  
Each service (Nginx, WordPress, MariaDB) runs in its own container.  

This ensures:
- reproducibility
- isolation
- portability  

Unlike virtual machines, Docker containers share the host system's kernel and are therefore more lightweight.  
Each container runs a single main process in the foreground (PID 1), ensuring proper signal handling and clean container lifecycle management.  

### 🏗️ Project Structure
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

### 🧪 Required Comparisons
#### 💻 **Virtual Machine** vs **Docker**
| **Virtual Machines**   | **Docker**                       |
|------------------------|----------------------------------|
| Full OS virtualization | Application-level virtualization |
| Own kernel per VM      | Shared host kernel               |
| Heavy                  | Lightweight                      |
| Slow startup           | Fast startup                     |
| Strong isolation       | Lighter isolation                |

#### 🔐 **Secrets** vs **Environment Variables**
| **Secrets**                 | **Environment Variables**    |
|-----------------------------|------------------------------|
| Stored securely in files    | Stored in plain text         |
| Harder to expose            | Easier to leak               |
| Better security             | Less secure                  |

#### 📈 **Docker Network** vs **Host Network**
| **Docker Network**         | **Host Network**             |
|----------------------------|------------------------------|
| Isolated network           | Uses host network directly   |
| More secure                | Less secure                  |
| Container communication    | Direct access to host ports  |

#### 💿 **Volumes** vs **Bind Mounts**
| **Volumes**                | **Bind Mounts**              |
|----------------------------|------------------------------|
| Managed by Docker          | Linked to host filesystem    |
| More portable              | Host-dependent               |
| Abstracted storage         | More flexible                |
</br>

## 📂 Resources
### ✉️ Documentation
- **DevSecOps**: Comprendre les images docker by Stéphane Robert
- **DevSecOps**: Guide Dockerfile by Stéphane Robert
- **Docker official documentation**: (build secrets...)
- **YouTube video by NetworkChuck**: docker compose
### 🤖 Use of AI
- Debugging (especially for the mariadb check loop in wordpress container)
- explanation of some of bash commands
- improving my Makefile

Globaly, AI was used as a support tool, to assist in understanding and cleaning some part of the project.
</br>

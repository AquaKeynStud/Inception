# 👤 User Documentation

## 📖 Overview

This project provides a complete web infrastructure composed of:
- a **web server** (Nginx)
- a **WordPress application**
- a **MariaDB database**

All services run inside Docker containers and are automatically connected.

---

## 🚀 Start and Stop the Project

### ▶️ Start

```bash
make up
```
### ⛔ Stop

```bash
make down
```

## 🌐 Access the Website

Open your browser and go to: `https://arocca.42.fr`

## 🔐 Access the Administration Panel

To access the WordPress admin panel: `https://arocca.42.fr/wp-admin`
Use the administrator credentials in secret files.
You can change what's following the `=`, or the value if none are in the file.
## 🔑 Credentials Management

Credentials are stored in the `secrets/` directory.

**⚠️ These files must remain private and should never be pushed to a repository.**

## ✅ Check Services Status

### 📦 List running containers
```bash
docker ps
```

### 📜 View logs
```bash
make logs
```

### 🔍 Check specific service
```bash
docker logs <container_name>
```

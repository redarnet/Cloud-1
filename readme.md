# Cloud-1 

## 📌 Présentation du projet

Ce projet a été réalisé dans le cadre du **projet Cloud-1 de l'école 42**. L'objectif est de déployer **automatiquement** une application WordPress complète sur un serveur distant, en respectant des contraintes strictes de **sécurité**, de **persistance des données**, et d'**orchestration des services**.

Le déploiement est entièrement automatisé à l'aide d'**Ansible**, et l'application repose sur une architecture  Docker Compose**,testée et fonctionnelle sur **une instance Scaleway**.

---

## 🏗️ Architecture globale

L'infrastructure déployée sur Scaleway repose sur les composants suivants :

* **Nginx** : reverse proxy, point d'entrée unique (HTTP/HTTPS)
* **WordPress** : application web
* **MySQL** : base de données
* **PhpMyAdmin** : interface d'administration MySQL
* **Docker & Docker Compose** : conteneurisation et orchestration
* **Ansible** : automatisation complète du déploiement
* **Certbot** : gestion automatique des certificats TLS/HTTPS

Tous les services communiquent via un **réseau Docker privé**.


---

## ⚙️ Technologies utilisées

* Instance **Scaleway** (Ubuntu / Debian)
* Ansible
* Docker Compose
* Nginx
* WordPress
* MySQL 8.0
* PhpMyAdmin
* Certbot
* TLS / HTTPS

---

## 🚀 Déploiement automatisé

Le déploiement est réalisé via un **playbook Ansible** sur une instance Scaleway.


---

## 🐳 Architecture Docker

Chaque service tourne dans son **container dédié** :

| Service    | Container       | Port exposé |
| ---------- | --------------- | ----------- |
| Nginx      | wordpress_nginx | 80 / 443    |
| WordPress  | wordpress_app   | Aucun       |
| MySQL      | wordpress_db    | Aucun       |
| PhpMyAdmin | phpmyadmin      | Aucun       |

Seul **Nginx** expose des ports vers l'extérieur.

Tous les services sont **hébergés sur l'instance Scaleway** et utilisent un **réseau Docker interne sécurisé**.

---

## 💾 Persistance des données

La persistance est assurée grâce à **deux types de volumes Docker** :

### Volumes nommés

* `db_data` → données MySQL
* `wordpress_data` → fichiers WordPress

Ces volumes persistent même après :

* redémarrage de l'instance Scaleway
* suppression des containers

### Bind mounts

Utilisés pour :

* configuration Nginx
* certificats TLS (mis à jour automatiquement par Certbot)

---

## 🔐 Sécurité

Plusieurs mesures de sécurité sont mises en place sur l'instance Scaleway :

* Aucun accès direct à la base de données depuis Internet
* MySQL accessible uniquement via le réseau Docker interne
* Séparation des privilèges MySQL :

  * `root` utilisé uniquement pour l'initialisation
  * utilisateur dédié pour WordPress
* Variables sensibles stockées dans un fichier `.env`

---

## 🔒 TLS / HTTPS avec Certbot

Le rôle **certbot** s'occupe de générer et renouveler automatiquement les certificats TLS pour Nginx sur Scaleway.

* Les certificats sont stockés dans un bind mount sur l'hôte (`/opt/wordpress/nginx/certs`)
* Nginx lit les certificats depuis ce volume
* TLS est actif et toutes les connexions sont chiffrées
* Le renouvellement automatique est pris en charge par Certbot, sans intervention manuelle


---

## 🌍 Accès à l'application

* WordPress : `https://darnetremi.fr`
* PhpMyAdmin : `https://darnetremi.fr/phpmyadmin`

Actuellement désactivé  par soucis de budjet.


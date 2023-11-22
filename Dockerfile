# Utiliser l'image officielle de Node pour Vue.js
FROM node:lts AS builder

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers du projet dans le conteneur
COPY . .

RUN npm install -g npm@10.2.4
# Installer les dépendances
RUN npm install

# Build du projet
RUN npm run build

# Étape de production
FROM nginx:stable-alpine

# Copier les fichiers de build dans le dossier de travail de Nginx
COPY --from=builder /app/dist /usr/share/nginx/html

# Exposer le port 80
EXPOSE 80

# Commande de démarrage de Nginx
CMD ["nginx", "-g", "daemon off;"]

# Etapa de construcción
FROM node:18 as build
WORKDIR /app

# Copiar archivos de configuración
COPY package.json package-lock.json ./

# Instalar dependencias
RUN npm install

# Copiar el código fuente
COPY . .

# Compilar el proyecto
RUN npm run build

# Etapa de producción
FROM nginx:alpine

# Copiar los archivos del cliente (Angular)
COPY --from=build /app/dist/api-spendwise-angular/browser /usr/share/nginx/html

# Copiar la configuración personalizada de Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Exponer el puerto 80
EXPOSE 80

# Iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]
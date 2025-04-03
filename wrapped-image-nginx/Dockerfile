FROM gcr.io/silken-period-452805-a7/rock-music-band:v13

RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

COPY default.conf /etc/nginx/sites-enabled/default

EXPOSE 8080

# 🧠 Force PORT=8080 and start your app + nginx
CMD /bin/sh -c "export PORT=8080 && cd /app && node server.js & nginx -g 'daemon off;'"


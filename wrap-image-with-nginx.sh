#!/bin/bash

# === CONFIGURATION ===
PROJECT_ID="silken-period-452805-a7"
IMAGE_NAME="rock-music-band"
SOURCE_TAG="v13"
WRAPPED_TAG="v104"
FULL_IMAGE="gcr.io/$PROJECT_ID/$IMAGE_NAME:$WRAPPED_TAG"
WORKDIR="wrapped-image-nginx"

echo "🛠️ Creating working directory: $WORKDIR"
mkdir -p "$WORKDIR"
cd "$WORKDIR" || exit 1

# === Create default.conf (NGINX Proxy Config) ===
echo "📝 Creating default.conf"
cat > default.conf <<'EOF'
server {
    listen 8080;

    location / {
        proxy_pass http://127.0.0.1:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
EOF

# === Create Dockerfile ===
echo "📝 Creating Dockerfile"
cat > Dockerfile <<EOF
FROM gcr.io/$PROJECT_ID/$IMAGE_NAME:$SOURCE_TAG

# Install NGINX
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# Copy NGINX config to proper location
COPY default.conf /etc/nginx/sites-enabled/default

# App Engine expects port 8080
EXPOSE 8080

# Start NGINX and leave the original app's CMD intact
CMD /bin/sh -c "nginx && sleep 2 && tail -f /dev/null"
EOF

# === Create app.yaml ===
echo "📝 Creating app.yaml"
cat > app.yaml <<EOF
runtime: custom
env: flex
service: default

automatic_scaling:
  min_num_instances: 1
  max_num_instances: 2

resources:
  cpu: 1
  memory_gb: 1
  disk_size_gb: 10
EOF

# === Create README.md ===
echo "📘 Creating README.md"
cat > README.md <<EOF
# 🎯 App Engine Deployment: NGINX Proxy for Prebuilt Image

This setup wraps your existing Docker image (**$IMAGE_NAME:$SOURCE_TAG**) and uses **NGINX** to forward traffic from **port 8080 → 3000**, making it compatible with **Google App Engine Flex**, which requires apps to listen on **8080**.

---

## 🛠 Files

- \`Dockerfile\`: Wraps and forwards ports using NGINX
- \`default.conf\`: NGINX config
- \`app.yaml\`: App Engine Flex deployment configuration

---

## 🚀 How to Use

### 1. Build the wrapped image
\`\`\`bash
docker build -t $FULL_IMAGE .
\`\`\`

### 2. Push the image to GCR
\`\`\`bash
docker push $FULL_IMAGE
\`\`\`

### 3. Deploy to App Engine
\`\`\`bash
gcloud beta app deploy \\
  --image-url=$FULL_IMAGE \\
  --project=$PROJECT_ID \\
  --quiet
\`\`\`

---

## 🔍 How It Works

- Your original app (on port **3000**) is untouched
- NGINX is installed and listens on **8080**
- All traffic is proxied to your app
- App Engine Flex routes requests to **8080** ✅

---

## ✅ After Deployment

Your app will be available at:

👉 https://$PROJECT_ID.uc.r.appspot.com

To check logs:

\`\`\`bash
gcloud app logs tail -s default
\`\`\`

---
EOF

# === Build, Push & Deploy ===
echo "🐳 Building Docker image..."
docker build -t "$FULL_IMAGE" .

echo "☁️ Pushing image to GCR..."
docker push "$FULL_IMAGE"

echo "🚀 Deploying to App Engine..."
gcloud beta app deploy \
  --image-url="$FULL_IMAGE" \
  --project="$PROJECT_ID" \
  --quiet

echo "✅ DONE! Your wrapped app should now be live at:"
echo "👉 https://$PROJECT_ID.uc.r.appspot.com"


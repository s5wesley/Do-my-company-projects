# 🎯 App Engine Deployment: NGINX Proxy for Prebuilt Image

This setup wraps your existing Docker image (**rock-music-band:v13**) and uses **NGINX** to forward traffic from **port 8080 → 3000**, making it compatible with **Google App Engine Flex**, which requires apps to listen on **8080**.

---

## 🛠 Files

- `Dockerfile`: Wraps and forwards ports using NGINX
- `default.conf`: NGINX config
- `app.yaml`: App Engine Flex deployment configuration

---

## 🚀 How to Use

### 1. Build the wrapped image
```bash
docker build -t gcr.io/silken-period-452805-a7/rock-music-band:v104 .
```

### 2. Push the image to GCR
```bash
docker push gcr.io/silken-period-452805-a7/rock-music-band:v104
```

### 3. Deploy to App Engine
```bash
gcloud beta app deploy \
  --image-url=gcr.io/silken-period-452805-a7/rock-music-band:v104 \
  --project=silken-period-452805-a7 \
  --quiet
```

---

## 🔍 How It Works

- Your original app (on port **3000**) is untouched
- NGINX is installed and listens on **8080**
- All traffic is proxied to your app
- App Engine Flex routes requests to **8080** ✅

---

## ✅ After Deployment

Your app will be available at:

👉 https://silken-period-452805-a7.uc.r.appspot.com

To check logs:

```bash
gcloud app logs tail -s default
```

---

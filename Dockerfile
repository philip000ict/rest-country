# Dockerfile
# Use an official NGINX image to serve the static files
FROM nginx:alpine

# Copy the built Vue app to the NGINX html directory
COPY dist/ /usr/share/nginx/html

# Optional: replace default NGINX config with your own
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose the default port
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]

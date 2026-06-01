# Use lightweight stable nginx image from DockerHub
FROM nginx:stable-alpine

# Add metadata labels for tracking and ownership
LABEL maintainer="Reddy"
LABEL application="reddy-nginx"
LABEL environment="dev"

# Remove default nginx static website files
RUN rm -rf /usr/share/nginx/html/*

# Copy custom index.html from local project to nginx web root
COPY index.html /usr/share/nginx/html/index.html

# Expose container port 80
EXPOSE 80

# Health check to verify nginx is responding
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost/ || exit 1

# Start nginx in foreground mode
# Required because containers must keep main process running
CMD ["nginx", "-g", "daemon off;"]
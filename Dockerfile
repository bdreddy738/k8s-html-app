# Use lightweight stable nginx image
FROM nginx:stable-alpine

# Metadata
LABEL maintainer="Reddy"
LABEL application="reddy-nginx"
LABEL environment="dev"

# Remove default nginx static files
RUN rm -rf /usr/share/nginx/html/*

# Copy application files
COPY index.html /usr/share/nginx/html/index.html

# Expose container port
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost/ || exit 1

# Start nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
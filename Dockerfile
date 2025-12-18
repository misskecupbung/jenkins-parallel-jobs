# Nginx container based on Red Hat UBI 8
# Configured to run as non-root user on port 8080

FROM registry.access.redhat.com/ubi8:8.0

LABEL maintainer="your-email@example.com" \
      description="Nginx web server running as non-root user"

# Install Nginx and clean up
RUN yum install -y --disableplugin=subscription-manager --nodocs nginx \
    && yum clean all \
    && rm -rf /var/cache/yum

# Copy web content
COPY index.html /usr/share/nginx/html/

# Apply Nginx configuration changes for non-root operation
COPY nginxconf.sed /tmp/
RUN sed -i -f /tmp/nginxconf.sed /etc/nginx/nginx.conf \
    && rm -f /tmp/nginxconf.sed

# Set up permissions for non-root user
RUN touch /run/nginx.pid \
    && chgrp -R 0 /var/log/nginx /run/nginx.pid \
    && chmod -R g+rwx /var/log/nginx /run/nginx.pid

EXPOSE 8080

# Run as non-root user
USER 1001

CMD ["nginx", "-g", "daemon off;"]

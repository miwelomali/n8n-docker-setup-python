FROM n8nio/n8n:latest

# Install additional packages if needed
USER root
RUN apk add --no-cache \
    python3 \
    py3-pip \
    build-base \
    python3-dev

# Switch back to node user
USER node

# Set working directory
WORKDIR /home/node

# Copy custom configurations if any
# COPY --chown=node:node custom-nodes/ /home/node/.n8n/custom/

# Expose port
EXPOSE 5678

# Start n8n
CMD ["n8n", "start"]
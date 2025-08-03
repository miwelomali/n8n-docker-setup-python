#!/bin/bash

echo "Setting up n8n with Docker and SSL certificates..."

# Create necessary directories
mkdir -p nginx/ssl
mkdir -p n8n/local_files

# Check if mkcert is installed
if ! command -v mkcert &> /dev/null; then
    echo "mkcert is not installed. Installing mkcert..."
    
    # Install mkcert based on OS
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        curl -JLO "https://dl.filippo.io/mkcert/latest?for=linux/amd64"
        chmod +x mkcert-v*-linux-amd64
        sudo mv mkcert-v*-linux-amd64 /usr/local/bin/mkcert
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        if command -v brew &> /dev/null; then
            brew install mkcert
        else
            echo "Please install Homebrew first or install mkcert manually"
            exit 1
        fi
    else
        echo "Please install mkcert manually for your operating system"
        echo "Visit: https://github.com/FiloSottile/mkcert#installation"
        exit 1
    fi
fi

# Install local CA
echo "Installing local CA..."
mkcert -install

# Generate certificates for localhost
echo "Generating SSL certificates for localhost..."
cd nginx/ssl
mkcert localhost 127.0.0.1 ::1
cd ../..

# Make init script executable
chmod +x init-data.sh

echo "Setup complete!"
echo ""
echo "To start n8n:"
echo "1. Run: docker-compose up -d"
echo "2. Wait for services to start (about 30-60 seconds)"
echo "3. Open: https://localhost"
echo ""
echo "To view logs: docker-compose logs -f"
echo "To stop: docker-compose down"
echo ""
echo "Note: You may need to accept the self-signed certificate in your browser"
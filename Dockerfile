# Use Ubuntu as the base image
FROM ubuntu:20.04

# Avoid interactive prompts during apt install
ENV DEBIAN_FRONTEND=noninteractive

# Install Node.js and npm
RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean

# Create app directory
WORKDIR /app

# Copy package.json and package-lock.json first (if you have them)
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy the rest of the application code
COPY . .

# Expose port 80
EXPOSE 80

# Set environment variable for Node.js to use port 80
ENV PORT=80

# Start the Node.js app
CMD ["node", "index.js"]

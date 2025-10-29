# Stage 1: Base
FROM node:20-alpine AS base

# Install necessary system dependencies
RUN apk add --no-cache dumb-init

# Set working directory
WORKDIR /app

# Copy dependency files
COPY package*.json ./

# Stage 2: Development
FROM base AS development

# Install all dependencies (including dev)
RUN npm ci

# Copy all code
COPY . .

# Expose application port
EXPOSE 3000

# Non-root user for security
USER node

# Development command with nodemon
CMD ["dumb-init", "npm", "run", "dev"]

# Stage 3: Production
FROM base AS production

# Install production dependencies only
RUN npm ci --only=production && npm cache clean --force

# Copy all code
COPY --chown=node:node . .

# Expose application port
EXPOSE 3000

# Non-root user for security
USER node

# Production command
CMD ["dumb-init", "node", "src/server.js"]


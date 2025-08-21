# Multi-stage Dockerfile for Node.js Application
# Demonstrates production-ready containerization best practices

# Build Stage
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package files for dependency caching
COPY package*.json ./

# Install ALL dependencies (including devDependencies)
RUN npm ci --only=production=false

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Remove development dependencies
RUN npm prune --production

# Production Stage
FROM node:18-alpine AS production

# Create non-root user for security
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nextjs -u 1001

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install only production dependencies
RUN npm ci --only=production && \
    npm cache clean --force

# Copy built application from builder stage
COPY --from=builder --chown=nextjs:nodejs /app/dist ./dist
COPY --from=builder --chown=nextjs:nodejs /app/public ./public

# Copy any additional production files
COPY --chown=nextjs:nodejs start.js ./

# Create logs directory
RUN mkdir logs && chown nextjs:nodejs logs

# Switch to non-root user
USER nextjs

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1

# Set environment variables
ENV NODE_ENV=production
ENV PORT=3000

# Start the application
CMD ["node", "start.js"]
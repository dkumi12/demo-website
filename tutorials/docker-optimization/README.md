# Multi-stage Docker Build Tutorial

This tutorial demonstrates Docker best practices for creating optimized, secure production containers.

## What You'll Learn

- Multi-stage Docker builds for size optimization
- Security best practices for containers
- Node.js application containerization
- Production-ready configurations

## Prerequisites

- Docker installed and running
- Basic understanding of Docker concepts
- Node.js application (sample provided)

## Docker Best Practices Demonstrated

### 1. Multi-Stage Builds
- Build stage with all development dependencies
- Production stage with only runtime dependencies
- Significant size reduction (500MB → 150MB typical)

### 2. Security Hardening
- Non-root user execution
- Minimal base image (Alpine Linux)
- No unnecessary packages or files
- Proper file permissions

### 3. Performance Optimization
- Layer caching for faster builds
- .dockerignore for smaller build context
- Efficient instruction ordering
- Health checks for container monitoring

## Tutorial Steps

### 1. Examine the Dockerfile
```bash
# Review the multi-stage Dockerfile
cat Dockerfile
```

### 2. Build the Optimized Image
```bash
# Build with build-time optimizations
docker build -t demo-app:optimized .
```

### 3. Compare Image Sizes
```bash
# Check image size
docker images demo-app:optimized

# Compare with basic build
docker build -t demo-app:basic -f Dockerfile.basic .
docker images | grep demo-app
```

### 4. Run and Test
```bash
# Run the optimized container
docker run -p 3000:3000 --name demo-app demo-app:optimized

# Test the application
curl http://localhost:3000
curl http://localhost:3000/health
```

### 5. Security Scan
```bash
# Scan for vulnerabilities
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
  aquasec/trivy image demo-app:optimized
```

## Expected Results

### Size Comparison
- **Basic Build**: ~500MB (includes dev dependencies, build tools)
- **Optimized Build**: ~150MB (production-only, Alpine base)
- **Reduction**: 70% smaller container

### Security Improvements
- Runs as non-root user (security best practice)
- Minimal attack surface (Alpine Linux base)
- No package managers or build tools in final image
- Proper file permissions and ownership

### Performance Benefits
- Faster container startup (smaller image)
- Reduced network transfer time
- Lower storage costs
- Better resource utilization

## Production Considerations

### Environment Variables
```bash
# Production environment setup
docker run -p 3000:3000 \
  -e NODE_ENV=production \
  -e PORT=3000 \
  -e LOG_LEVEL=info \
  demo-app:optimized
```

### Health Monitoring
```bash
# Check container health
docker inspect demo-app --format='{{.State.Health.Status}}'
```

### Resource Limits
```bash
# Run with resource constraints
docker run -p 3000:3000 \
  --memory=256m \
  --cpus=0.5 \
  demo-app:optimized
```

## Cleanup
```bash
# Stop and remove containers
docker stop demo-app
docker rm demo-app

# Remove images
docker rmi demo-app:optimized demo-app:basic
```
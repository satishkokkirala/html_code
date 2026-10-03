# =========================
# Stage 1: Build Stage
# =========================

FROM alpine:latest AS build

# Create application directory
WORKDIR /app

# Create a non-root user
RUN addgroup -S htmlgroup && \
    adduser -S htmluser -G htmlgroup

# Copy HTML files
COPY index.html .

# Change ownership
RUN chown -R htmluser:htmlgroup /app

# Switch to non-root user
USER htmluser


# =========================
# Stage 2: Production Stage
# =========================

FROM nginx:alpine

# Metadata
LABEL maintainer="Satish"
LABEL application="FLM HTML Application"

# Copy HTML from build stage
COPY --from=build /app/index.html /usr/share/nginx/html/index.html

# Expose HTTP port
EXPOSE 80

# Run Nginx in foreground
CMD ["nginx", "-g", "daemon off;"]

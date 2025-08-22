# Use Node.js lightweight image
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Install static file server
RUN npm install -g serve@14

# Copy prebuilt React dist folder
COPY dist ./dist

# Expose port 3000
EXPOSE 3000

# Command to run the app
CMD ["serve", "-s", "dist", "-l", "3000"]



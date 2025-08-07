# Use a lightweight web server (Nginx) to serve the static files
FROM nginx:alpine

# Remove the default nginx index page
RUN rm -rf /usr/share/nginx/html/*

# Copy your built React app (dist folder) into the Nginx web directory
COPY dist/ /usr/share/nginx/html


# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]


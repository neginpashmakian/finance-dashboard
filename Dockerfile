# Step 1: Use an official Node.js runtime as a base image
FROM node:16-alpine AS build

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Copy package.json and package-lock.json
COPY package*.json ./

# Step 4: Install dependencies
RUN npm install

# Step 5: Copy the entire project into the container
COPY . .

# Step 6: Build the Vue app
RUN npm run build

# Step 7: Use Nginx to serve the app
FROM nginx:alpine

# Step 8: Copy built files from the previous stage to Nginx's web directory
COPY --from=build /app/dist /usr/share/nginx/html

# Step 9: Expose port 80 for the server
EXPOSE 80

# Step 10: Start Nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]

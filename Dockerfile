# Use a smaller base image
FROM node:18-alpine

# Install necessary system dependencies
RUN apk update && \
    apk add --no-cache git

# Set the working directory
WORKDIR /root/strapi

# Copy package.json and yarn.lock
COPY package.json yarn.lock ./

# Install dependencies
RUN yarn install --production

# Install pm2 globally
RUN yarn global add pm2

# Copy the rest of the application
COPY . .

# Expose port 1337
EXPOSE 1337

# Start the application using pm2-runtime
CMD ["pm2-runtime", "start", "npm", "--", "run", "start"]

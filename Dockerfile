# Use the official Node.js 20 image as it supports Corepack
FROM node:20

# Enable Corepack to manage package managers
RUN corepack enable

# Set the working directory in the container to /app
WORKDIR /app

# Node uses a non-root user 'node' by default in their official images, setting ownership:
# This step is crucial if there are permissions issues during pnpm install
COPY --chown=node:node . .

# Use the non-root user to run subsequent commands
USER node

# Copy the package.json and pnpm-lock.yaml files to the working directory
# Ensure you also copy any other relevant config files like .pnpmfile.cjs if you have one
COPY package.json pnpm-lock.yaml* ./

# Prepare pnpm using Corepack and activate the specified version
RUN corepack prepare pnpm@9.0.2 --activate

# Install dependencies using pnpm
RUN pnpm install

# Expose the port the app runs on
EXPOSE 8080

# Command to run the application, adjust according to your package.json scripts
CMD ["pnpm", "run", "dev"]

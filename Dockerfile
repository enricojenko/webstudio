# Use the official Node.js 20 image as it supports Corepack
FROM node:20

# Enable Corepack to manage package managers
RUN corepack enable

# Set the working directory in the container to /app
WORKDIR /app

# Copy the package.json and pnpm-lock.yaml files to the working directory
# Ensure you also copy any other relevant config files like .pnpmfile.cjs if you have one
COPY package.json pnpm-lock.yaml* ./

# Prepare pnpm using Corepack and activate the specified version
RUN corepack prepare pnpm@9.0.2 --activate

# Install dependencies using pnpm
RUN pnpm install

# Copy the rest of your application code to the container
COPY . .

# Expose the port the app runs on
EXPOSE 8080

# Command to run the application, adjust according to your package.json scripts
CMD ["pnpm", "run", "dev"]

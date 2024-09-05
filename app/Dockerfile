# Stage 1: Build stage
FROM node:18-alpine as build-stage

WORKDIR /app

# Copy package.json and install dependencies
COPY package.json .

RUN npm install

# Copy the rest of the application code
COPY . .

# Stage 2: Production stage
FROM node:18-alpine

WORKDIR /app

# Copy necessary files from build stage
COPY --from=build-stage /app .

EXPOSE 80

# Run the application
CMD ["npm", "start"]

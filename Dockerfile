FROM node:22-bookworm
USER root
RUN apt-get update && \
    apt-get install -y ffmpeg webp git && \
    apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*
    
# Set the working directory
WORKDIR /home/node/app

# Copy all files from your connected GitHub repo into the container
COPY . .

# Grant read/write permissions
RUN chmod -R 777 /home/node/app

# Install the bot's dependencies
RUN yarn install --network-concurrency 1

EXPOSE 7860
ENV NODE_ENV=production
CMD ["npm", "start"]
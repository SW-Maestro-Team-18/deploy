FROM nginx:1.21

WORKDIR /app
COPY ./server /app

RUN apt-get update && \
    apt-get install -y python3-pip systemctl

# Install required packages
RUN pip3 install -r requirements.txt

# Expose the Nginx HTTP port
EXPOSE 80

#COPY ./client /static
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./client /static
COPY ./run.sh /run.sh

RUN chmod +x /run.sh
CMD ["bash", "-c", "sh /run.sh"]


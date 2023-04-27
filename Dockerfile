FROM nginx:1.21

WORKDIR /app

COPY ./server /app
#COPY ./client /static
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./supervisord.conf /etc/supervisor/supervisord.conf

RUN apt-get update && \
    apt-get install -y python3-pip

# Install required packages
RUN pip3 install -r requirements.txt

# Expose the Nginx HTTP port
EXPOSE 80

CMD ["bash", "-c", "/usr/sbin/nginx -c /etc/nginx/nginx.conf"]
CMD ["bash", "-c", "uvicorn --host 0.0.0.0 --port 8000 main:app"]

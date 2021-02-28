FROM ubuntu:20.04

RUN apt update -y && apt install -y wget gnupg2 systemd curl && \
    wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add - && \
    apt install -y apt-transport-https && \
    echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-7.x.list && \
    apt update -y && apt install -y filebeat=7.11.1 metricbeat=7.11.1 heartbeat-elastic=7.11.1 packetbeat=7.11.1 nginx

COPY filebeat.yml /etc/filebeat/filebeat.yml

COPY metricbeat.yml /etc/metricbeat/metricbeat.yml

COPY heartbeat.yml /etc/heartbeat/heartbeat.yml

COPY packetbeat.yml /etc/packetbeat/packetbeat.yml

COPY server.conf /etc/nginx/sites-available/default

COPY entrypoint.sh wait-for-it.sh ./

EXPOSE 80

ENTRYPOINT "./entrypoint.sh"
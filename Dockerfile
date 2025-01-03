FROM debian:bookworm
RUN apt update ; apt install wget -y 
RUN echo 'deb http://download.proxmox.com/debian/pdm bookworm pdm-test' >/etc/apt/sources.list.d/pdm-test.list 
RUN wget https://enterprise.proxmox.com/debian/proxmox-release-bookworm.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-bookworm.gpg
RUN apt update ; yes Y | apt install proxmox-datacenter-manager proxmox-datacenter-manager-ui -y 
COPY prox-dc-start-up.sh /start.sh
RUN chmod 755 /start.sh
EXPOSE 8443/tcp 

CMD ["bash", "-c", "/start.sh" ]

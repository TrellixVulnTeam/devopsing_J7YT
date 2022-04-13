FROM ubuntu
ENV LDAP_IP 172.17.0.2
EXPOSE 389 636 53 80 8080
RUN apt upgrade -y && apt update -y && apt install sssd -y && apt install openssl -y && apt install ca-certificates -y
COPY sssd.conf /etc/sssd/
RUN chmod 600 -R /etc/sssd
RUN openssl s_client -connect ${LDAP_IP}:636 </dev/null | openssl x509 -outform PEM -out cert.pem
RUN cp cert.pem /usr/local/share/ca-certificates/ca.crt && update-ca-certificates
RUN echo "${LDAP_IP}    myldap.example.com" >> /etc/hosts && service sssd start && service sssd status



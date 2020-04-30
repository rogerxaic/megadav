FROM carlosroman/megacmd

COPY entrypoint.sh /

EXPOSE 4443

ENV MEGA_EMAIL=
ENV MEGA_PASSWORD=
ENV MEGA_SESSION=

ENTRYPOINT ["/entrypoint.sh"]

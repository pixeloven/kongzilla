FROM alpine

WORKDIR /usr/local/bin

COPY setup.sh setup
RUN chmod +x setup
RUN apk --update add curl jq && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

ENTRYPOINT ["setup"]
CMD ["setup"]
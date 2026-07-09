FROM alpine:latest
RUN apk add --no-cache curl bash
COPY alert.sh /alert.sh
RUN chmod +x /alert.sh
# Open port 8080 for cloud visibility
EXPOSE 8080
CMD ["/bin/bash", "/alert.sh"]
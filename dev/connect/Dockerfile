FROM eclipse-temurin:25-jre

ARG KAFKA_VERSION=4.0.2
ENV KAFKA_HOME=/opt/kafka
ENV PATH="${KAFKA_HOME}/bin:${PATH}"

RUN apt-get update && apt-get install -y curl bash && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL "https://downloads.apache.org/kafka/${KAFKA_VERSION}/kafka_2.13-${KAFKA_VERSION}.tgz" \
    -o /tmp/kafka.tgz \
 && mkdir -p /opt \
 && tar -xzf /tmp/kafka.tgz -C /opt \
 && mv /opt/kafka_2.13-${KAFKA_VERSION} ${KAFKA_HOME} \
 && rm /tmp/kafka.tgz

COPY scripts/start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8083
CMD ["/start.sh"]
FROM gcc AS builder

COPY . .
RUN make

FROM debian:11

WORKDIR /
COPY --from=builder bin/* ./bin/

RUN apt update && apt install -y net-tools squid
COPY tools/squid.conf /etc/squid/
COPY tools/start.sh .
COPY tools/generate-cert.sh .

CMD ["./start.sh"]
EXPOSE 53/UDP

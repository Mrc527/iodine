FROM debian:13 AS builder

RUN apt update && apt install -y build-essential git pkg-config meson ninja-build check zlib1g-dev
WORKDIR /src
COPY . .
RUN meson setup build
RUN ninja -C build
RUN meson test -C build

FROM debian:13

WORKDIR /
COPY --from=builder /src/build/iodine /src/build/iodined /usr/local/sbin/

RUN apt update && apt install -y net-tools squid
COPY tools/squid.conf /etc/squid/
COPY tools/start.sh .
COPY tools/generate-cert.sh .

CMD ["./start.sh"]
EXPOSE 53/UDP

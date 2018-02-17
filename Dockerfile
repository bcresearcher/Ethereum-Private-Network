FROM alpine:latest

LABEL version="0.1"
LABEL maintainer="civilbots@gmail.com"

RUN apk add --no-cache go make gcc musl-dev linux-headers bash git ca-certificates
RUN git clone --depth 1 https://github.com/ethereum/go-ethereum
RUN cd go-ethereum && make geth
RUN cp /go-ethereum/build/bin/geth /usr/local/bin/

RUN adduser -S eth_user

COPY eth_common /home/eth_user/eth_common

USER eth_user

WORKDIR /home/eth_user

RUN geth init eth_common/genesis.json

EXPOSE 8545 8546 30303 30303/udp 30304/udp

ENTRYPOINT bash

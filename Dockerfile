FROM ubuntu:18.04

ARG USER_ID
ARG GROUP_ID

ENV HOME /bitcoin

# add user with specified (or default) user/group ids
ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -g ${GROUP_ID} bitcoin \
	&& useradd -u ${USER_ID} -g bitcoin -s /bin/bash -m -d /bitcoin bitcoin

RUN sed -i "s/archive\.ubuntu\.com/tw\.archive\.ubuntu\.com/g" /etc/apt/sources.list


RUN apt-get update
RUN apt-get install -y software-properties-common \
  && add-apt-repository -y ppa:bitcoin/bitcoin \
  && apt-get -y update \
  && apt-get install -y libdb4.8-dev libdb4.8++-dev
RUN apt install -y libboost-all-dev
RUN apt install -y libevent-dev
ADD ./bin /usr/local/bin
COPY ./conf/bitcoin.conf /bitcoin/.bitcoin/bitcoin.conf

VOLUME ["/bitcoin"]


WORKDIR /bitcoin
EXPOSE 18444 18442

CMD ["bitcoind","-rpcbind=0.0.0.0"]

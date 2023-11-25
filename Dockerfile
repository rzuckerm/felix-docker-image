FROM ubuntu:18.04

COPY FELIX_* hello_world.flx /tmp/
RUN apt-get update && \
    apt-get install -y git make g++ ocaml-native-compilers python3 && \
    mkdir -p /opt && \
    cd /opt && \
    git clone https://github.com/felix-lang/felix -b $(cat /tmp/FELIX_VERSION) && \
    cd felix && \
    . buildscript/linuxsetup.sh && \
    make build && \
    make install && \
    cd / && \
    apt-get remove -y git make ocaml-native-compilers python3 && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /opt/felix /root/.felix && \
    cd /tmp && \
    flx --static -o hello_world -c hello_world.flx && \
    rm -f hello_world* flxg_stats.txt

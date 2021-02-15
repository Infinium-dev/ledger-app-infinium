FROM ubuntu:20.04
ADD app /app
RUN apt update &&\
    apt install software-properties-common -y &&\
    add-apt-repository universe &&\
    apt update &&\
    apt install gcc-multilib g++-multilib git libudev-dev libusb-1.0-0-dev python2 python2-minimal python2-dev libudev-dev curl tar build-essential libtinfo5 python3-pip -y &&\
    mkdir -p ~/bolos-devenv &&\
    cd ~/bolos-devenv
ADD nanos-secure-sdk /root/bolos-devenv/nanos-secure-sdk
COPY compilers/clang+llvm-4.0.0-x86_64-linux-gnu-ubuntu-16.04.tar.xz /root/bolos-devenv/clang+llvm-4.0.0-x86_64-linux-gnu-ubuntu-16.04.tar.xz
COPY compilers/gcc-arm-none-eabi-5_3-2016q1-20160330-linux.tar.bz2 /root/bolos-devenv/gcc-arm-none-eabi-5_3-2016q1-20160330-linux.tar.bz2
COPY scripts/legder.sh /ledger.sh
RUN cd ~/bolos-devenv &&\
    tar xvfj gcc-arm-none-eabi-5_3-2016q1-20160330-linux.tar.bz2 &&\
    tar xvfJ clang+llvm-4.0.0-x86_64-linux-gnu-ubuntu-16.04.tar.xz &&\
    mv clang+llvm-4.0.0-x86_64-linux-gnu-ubuntu-16.04 clang-arm-fropi &&\
    curl https://bootstrap.pypa.io/2.7/get-pip.py -o get-pip.py &&\
    python2 get-pip.py &&\
    pip install ECPy==1.0.1 &&\
    pip3 install Pillow &&\
    pip install --user ledgerblue &&\
    apt install python screen -y &&\
    chmod +x /ledger.sh
CMD [ "./ledger.sh" ]
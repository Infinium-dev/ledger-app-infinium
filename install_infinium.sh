#!/bin/bash
cd compilers
wget http://releases.llvm.org/4.0.0/clang+llvm-4.0.0-x86_64-linux-gnu-ubuntu-16.04.tar.xz
cd ..
docker build . -t inf-ledger
docker run -t -i --privileged -v /dev/bus/usb:/dev/bus/usb inf-ledger
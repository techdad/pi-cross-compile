FROM ubuntu:18.04

# USAGE: docker run -it -v ~/raspberry/hello:/build techdad/pi-cross-compile

RUN apt-get update && apt-get install -y git && apt-get install -y build-essential

RUN git clone --progress --verbose https://github.com/raspberrypi/tools.git --depth=1 pitools

RUN apt-get install -y libncurses5-dev python-dev squashfs-tools
RUN apt-get install -y scons pps-tools g++-multilib libc6-dev-i386
RUN apt-get install -y bison libssl-dev libcap-dev libseccomp-dev wget
RUN apt-get install -y automake autoconf iproute2

ENV BUILD_FOLDER /build
WORKDIR ${BUILD_FOLDER}

ENV TOOL_HOME /pitools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64
ENV TOOL_PREFIX ${TOOL_HOME}/bin/arm-linux-gnueabihf

ENV CC $TOOL_PREFIX-gcc
ENV LD $TOOL_PREFIX-ld
ENV CXX $TOOL_PREFIX-g++
ENV STRIP $TOOL_PREFIX-strip
ENV AR $TOOL_PREFIX-ar
ENV RANLIB $TOOL_PREFIX-ranlib

#CMD ["/bin/bash", "-c", "make", "-f", "${BUILD_FOLDER}/Makefile"]
#CMD cd ${BUILD_FOLDER}; scons
#CMD ["make", "clean"]
CMD ["/bin/bash", "--login"]
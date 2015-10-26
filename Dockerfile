FROM mjdsys/ubuntu-saucy-i386
MAINTAINER sfate

RUN sed 's/main universe$/main restricted universe multiverse/' -i /etc/apt/sources.list && echo 'deb http://ppa.launchpad.net/gregory-hainaut/pcsx2.official.ppa/ubuntu saucy main' >>  /etc/apt/sources.list && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 508A982D7A617FF4
RUN sed -i 's/archive/old-releases/g' /etc/apt/sources.list

RUN apt-get update
RUN apt-get install -y pcsx2 xauth

RUN dpkg-reconfigure locales && locale-gen en_US.UTF-8 && /usr/sbin/update-locale LANG=en_US.UTF-8

RUN useradd pcsx2
WORKDIR /home/pcsx2

RUN touch /home/pcsx2/.Xauthority
USER pcsx2

CMD ["/usr/games/pcsx2"]

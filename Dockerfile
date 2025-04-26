FROM azul/zulu-openjdk:21

WORKDIR /server

COPY neoforge-installer.jar ./
RUN java -jar neoforge-installer.jar --installServer

COPY mods ./mods
COPY eula.txt ./

EXPOSE 25565

CMD ["bash", "run.sh"]
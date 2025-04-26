FROM azul/zulu-openjdk:17

WORKDIR /server

COPY neoforge-installer.jar ./
RUN java -jar neoforge-installer.jar --installServer

COPY mods ./mods
COPY eula.txt ./

EXPOSE 25565

CMD ["java", "-Xmx3G", "-Xms2G", "-jar", "neoforge-*.jar", "nogui"]
# ============================================================
# Done Farm Create V1.1.1 云服务器镜像
# MC 1.21.1 / NeoForge 21.1.234 / Linux x64（Zeabur 等容器平台）
# 构建时会安装 NeoForge 服务端并拉取 Linux 版运行库
# 存档由首次启动用种子自动生成，world 目录请挂持久卷
# ============================================================
FROM eclipse-temurin:21-jdk

ENV NEOFORGE_VERSION=21.1.234
WORKDIR /mc

# 1) 原版服务端 jar（BMCLAPI 镜像；SHA1 已在本机验证）
RUN curl -fL --retry 5 -o minecraft_server.1.21.1.jar \
    "https://bmclapi2.bangbang93.com/version/1.21.1/server" \
 && echo "59353fb40c36d304f2035d51e7d6e6baa98dc05c  minecraft_server.1.21.1.jar" | sha1sum -c - || (echo "SHA1 mismatch, retrying direct" && rm -f minecraft_server.1.21.1.jar && curl -fL --retry 5 -o minecraft_server.1.21.1.jar "https://piston-meta.mojang.com/v1/packages/59353fb40c36d304f2035d51e7d6e6baa98dc05c/server.jar")

# 2) NeoForge 安装器 + 服务端安装（--mirror 走国内镜像，生成 Linux natives）
RUN curl -fL --retry 5 -o neoforge-installer.jar \
    "https://bmclapi2.bangbang93.com/maven/net/neoforged/neoforge/21.1.234/neoforge-21.1.234-installer.jar" \
 && java -jar neoforge-installer.jar --installServer /mc \
        --mirror https://bmclapi2.bangbang93.com/maven \
 && rm -f neoforge-installer.jar

# 3) 整合包资源（跨平台；服务端 mods 145 个，txnilib/irisflw 已排除）
COPY mods/            /mc/mods/
COPY config/          /mc/config/
COPY kubejs/          /mc/kubejs/
COPY datapacks/       /mc/datapacks/
COPY scripts/         /mc/scripts/
COPY server.properties /mc/server.properties
COPY user_jvm_args.txt /mc/user_jvm_args.txt
COPY eula.txt         /mc/eula.txt

# 4) 存档目录 —— Zeabur 请为 /mc/world 挂持久卷
#    首次启动自动按 level-seed=4776164391216949839 生成（Perfect Start 平原+村庄）
VOLUME /mc/world

EXPOSE 25565

CMD ["java", "@user_jvm_args.txt", "@libraries/net/neoforged/neoforge/21.1.234/unix_args.txt", "nogui"]

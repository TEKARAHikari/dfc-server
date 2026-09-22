# ============================================================
# Done Farm Create V1.1.1 云服务器镜像
# MC 1.21.1 / NeoForge 21.1.234 / Linux x64（Zeabur 等容器平台）
# 使用本地已验证的 NeoForge 服务端运行库，避免云端构建时下载超时
# 存档由首次启动用种子自动生成，world 目录请挂持久卷
# ============================================================
FROM eclipse-temurin:21-jdk

ENV NEOFORGE_VERSION=21.1.234
WORKDIR /mc

# 1) 本机 NeoForge 安装生成的运行库（含 Linux natives）
COPY libraries/        /mc/libraries/

# 2) 整合包资源（跨平台；服务端 mods 145 个，txnilib/irisflw 已排除）
COPY mods/            /mc/mods/
COPY config/          /mc/config/
COPY kubejs/          /mc/kubejs/
COPY datapacks/       /mc/datapacks/
COPY scripts/         /mc/scripts/
COPY server.properties /mc/server.properties
COPY user_jvm_args.txt /mc/user_jvm_args.txt
COPY eula.txt         /mc/eula.txt

# 3) 现有存档 —— Zeabur 请为 /mc/world 挂持久卷
COPY world/           /mc/world/
RUN rm -f /mc/world/session.lock

# 4) 存档目录 —— 持久卷挂载后保留游戏进度
VOLUME /mc/world

EXPOSE 25565

CMD ["java", "@user_jvm_args.txt", "@libraries/net/neoforged/neoforge/21.1.234/unix_args.txt", "nogui"]

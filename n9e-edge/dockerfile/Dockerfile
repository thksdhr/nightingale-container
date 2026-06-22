FROM ubuntu:resolute

LABEL By="taoziG"
USER root

# 设置目标架构
ARG TARGETARCH
RUN echo "当前正在构建的镜像架构是: $TARGETARCH"

RUN ["apt", "update"]
RUN ["apt", "install", "-y", "ca-certificates", "tzdata", "curl"]


# 设置默认时区为上海，可通过环境变量TZ覆盖
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN ["mkdir","-p","/program/etc"]
COPY ./temp/${TARGETARCH}/n9e-edge /program/n9e-edge
WORKDIR /program
RUN chown -R root:root /program
RUN chmod +x n9e-edge
EXPOSE 19000

# 设置 程序入口
# ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["/program/n9e-edge","-configs","/program/etc"]

# 教程移步 blog.taozig.top

```
  n9e-edge:
    image: taozig/n9e-edge:latest
    container_name: taozig-n9e-edge
    restart: unless-stopped
    networks:
      - n9e-edge
    ports:
      - "19000:19000"
    environment:
      TZ: Asia/Shanghai
    volumes:
      - ./volumes/n9e-edge:/program/etc
```
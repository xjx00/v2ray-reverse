# V2Ray Heroku

## 概述

用于在 Heroku 上部署 v2ray-reverse。

**Heroku 为我们提供了免费的容器服务。**


## 镜像

本镜像不会因为大量占用资源而被封号。

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://dashboard.heroku.com/new?template=https%3A%2F%2Fgithub.com%2Fxjx00%2Fv2ray-reverse)

## ENV 设定

### UUID

`UUID` > `一个 UUID，供用户连接时验证身份使用`。

## 注意

WebSocket 路径为 `/`。

`alterId` 为 `64`。

V2Ray 将在部署时自动安装最新版本。


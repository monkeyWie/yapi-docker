## 介绍

开箱即用的`yapi` docker 镜像，基于构建出来的镜像可以快速的搭建一套 yapi 服务。

## 使用

## 准备事项

### 1. yapi 访问地址

先确定好 yapi 浏览器访问的地址，例如：`https://yapi.xxx.com`

### 2. mongoDB

在 mongoDB 中创建一个库，并创建一个用户进行授权，示例：

```js
//创建yapi库，用户名为yapi，密码为123456
use yapi;
db.createUser({user:"yapi",pwd:"123456", roles:[{ role:"dbOwner", db:"yapi" } ] })
```
## 运行服务

通过`docker run`传入对应的环境变量运行，内部服务端口为 3000。

- 示例：

```sh
docker run --name yapi \
    -e DB_SERVERNAME=127.0.0.1 \
    -e DB_DATABASE=yapi \
    -e DB_PORT=27017 \
    -e DB_USER=yapi \
    -e DB_PASS=123456 \
    -p 3000:3000 \
    liwei2633/yapi
```

管理员默认账号密码为：`admin@admin.com`+`ymfe.org`

- 环境变量：

| 变量名               | 描述               |
| -------------------- | ------------------ |
| DB_SERVERNAME        | mongoDB 服务器地址 |
| DB_PORT              | mongoDB 服务器端口 |
| DB_DATABASE          | 数据库名称         |
| DB_USER              | 数据库用户名       |
| DB_PASS              | 数据库用户密码     |

## 构建

```sh
docker build -t yapi:1.9.2 .
```

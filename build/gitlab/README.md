[![Build Status](https://github.com/monkeyWie/yapi-gitlab/workflows/CI/badge.svg)](https://github.com/monkeyWie/yapi-gitlab/actions?query=workflow%3ACI)

## 介绍

开箱即用的`yapi+gitlab` docker 镜像，基于构建出来的镜像可以快速的搭建一套支持 gitlab 登陆 yapi 服务。

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

### 3. gitlab

使用 gitlab 管理员账号登录，在`Profile Settings > Applications`页面中，创建一个`Application`用于授权 gitlab OAuth 登录，只需要勾选 API 权限即可，`Redirect URI`填`yapi访问地址`+`/api/user/login_by_token`，示例：

```
https://yapi.xxx.com/api/user/login_by_token
```

创建好之后得到`Application Id`和`Application Secret`，记录下来为后续做准备。

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
    -e GITLAB_HOST=https://gitlab.xxx.dev \
    -e GITLAB_CLIENT_ID=fcee6b6a872f8b11deccde0c9228c66dfd7b61d2d32e1e08c9fd9333c0fb31e2 \
    -e GITLAB_CLIENT_SECRET=443ce87cae2a6f2abbe080c2a9247d1da83f7a880fcbc69da7fa194655394eb5 \
    -e YAPI_HOST=https://yapi.xxx.com \
    -p 3000:3000 \
    liwei2633/yapi-gitlab
```

yapi 服务已禁止注册账号，只能通过 gitlab 或管理员账号进行登录，管理员默认账号密码为：`admin@admin.com`+`ymfe.org`

- 环境变量：

| 变量名               | 描述               |
| -------------------- | ------------------ |
| DB_SERVERNAME        | mongoDB 服务器地址 |
| DB_PORT              | mongoDB 服务器端口 |
| DB_DATABASE          | 数据库名称         |
| DB_USER              | 数据库用户名       |
| DB_PASS              | 数据库用户密码     |
| GITLAB_HOST          | gitlab 访问地址    |
| GITLAB_CLIENT_ID     | gitlab 应用 id     |
| GITLAB_CLIENT_SECRET | gitlab 应用密钥    |
| YAPI_HOST            | yapi 访问地址      |

## 构建

```sh
docker build -t yapi-gitlab:1.9.2 .
```

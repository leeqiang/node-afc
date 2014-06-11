
Automatically find the configuration
====================================

自动查找配置文件

## 安装

```

npm i afc

```

## 使用

```

var config = require('afc').config;

```

## 默认查找目录(不查询子目录)

- /etc
- process.env.PWD
- process.env.PWD/lib

自定义目录

```

var config = require('afc').set('dirs', []).config

```
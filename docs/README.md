---
title: false
---

# Aide Lua 使用文档

## 简介

[![license](https://img.shields.io/github/license/AideLua/AideLua?style=flat-square)](https://gitee.com/AideLua/AideLua/blob/master/LICENSE)
[![发行版](https://img.shields.io/github/v/tag/AideLua/AideLua?color=C71D23&label=发行版&logo=gitee&style=flat-square)](https://gitee.com/AideLua/AideLua/releases)

[![QQ 群: 628045718](https://img.shields.io/badge/QQ_群-628045718-0099FF?logo=TencentQQ&style=flat-square)](https://jq.qq.com/?_wv=1027&k=41q8mp8y)
[![QQ 频道: t37c1u1nmw](https://img.shields.io/badge/QQ_频道-t37c1u1nmw-0099FF?logo=TencentQQ&style=flat-square)](https://pd.qq.com/s/ncghvc)

Aide Lua 是一款依赖 Aide 的 Lua 编辑器<br>
Aide Lua 可以让您在移动设备上也能享受高级的、快速的软件开发<br>
Aide Lua 可以帮您从 Androlua+ 转移到 AIDE，再转移到 Android Studio<br>

[![AideLua/Aide Lua](https://gitee.com/AideLua/AideLua/widgets/widget_card.svg?colors=4183c4,ffffff,ffffff,e3e9ed,666666,9b9b9b)](https://gitee.com/AideLua/AideLua)

::: tip

1. 本文档部分说明格式为 「__变量名__ (数据类型): 说明」、「__数据类型__: 说明」

:::

## 使用须知

1. 本软件默认开启自动保存代码且无法关闭（自动保存触发条件：切换到其他应用、点击二次打包以及打包运行、打开其他文件、关闭文件、打开侧滑（大屏除外）、点击标签栏等）
2. 此软件不能用来开发大型项目
3. 此软件必须搭配编译器，不管你用的是真 Gradle 还是假 Gradle __(AIDE 属于假 Gradle)__
4. 要实现直接运行项目，必须导出 `LuaActivity`（默认是导出的），__并成功安装项目软件（先用 AIDE 打包，然后用 Aide Lua 打包，最后安装）__

## 下载

### Aide Lua Pro

[![Gitee 发行版)](https://img.shields.io/github/v/tag/AideLua/AideLua?color=C71D23&label=Gitee+发行版&logo=gitee&style=flat-square)](https://gitee.com/AideLua/AideLua/releases/latest)

#### 其他渠道 (可能更新不及时)

[![123云盘](https://img.shields.io/badge/123云盘--597dfc?style=flat-square)](https://www.123pan.com/s/G7a9-Yzck)
[![天翼云盘](https://img.shields.io/badge/天翼云盘--DF9C1F?style=flat-square)](https://cloud.189.cn/t/ZZ7RzijyqiUv)
[![腾讯微云](https://img.shields.io/badge/腾讯微云--2980ff?style=flat-square)](https://share.weiyun.com/oLiNtxMR)
[![百度网盘](https://img.shields.io/badge/百度网盘-密码_jxnb-06a7ff?style=flat-square)](https://pan.baidu.com/s/1j1RwisPR8iq1fPS3O_fl7Q?pwd=jxnb)

### AIDE 高级设置版

由于 AIDE 的特殊性，请下载「AIDE 高级设置版」进行操作

[![官网 (推荐)](https://img.shields.io/badge/官网-推荐-28B6F6?style=flat-square)](https://www.aidepro.top/)
[![蓝奏云 (官方)](https://img.shields.io/badge/蓝奏云-v2.6.45-FF6600?logo=icloud&style=flat-square&logoColor=white)](https://www.lanzouy.com/b00zdhbeb)

### Gradle for AIDE Pro

您可以使用 Gradle 来提供完整的编译功能。如果您不需要则可以忽略。

[![天翼云盘 (官方)](https://img.shields.io/badge/天翼云盘-官方-DF9C1F?style=flat-square)](https://cloud.189.cn/t/jAFR7vAVniuu)
[![123云盘 (镜像)](https://img.shields.io/badge/123云盘-镜像-597dfc?style=flat-square)](https://www.123pan.com/s/G7a9-c9ek)

## 安装软件

我正在制作[《刷机指南》](https://efadg.netlify.app/)，后续有安装第三方软件的教程，敬请期待☺️

### 快速入门

::: tip
如果您只有 AndroLua+ 基础，那么您可以阅读[《快速使用》](/quickly/README.md)
:::

#### 一、配置 AIDE Pro

1. 进入 `设置 - 高级设置 - 构建 & 运行`
2. 关闭 `启用 adrt调试文件` ，打开 `重定义Apk构建路径`、`启用Gradle`（如果不使用 Gradle 则无需打开此项）
3. 重启 AIDE

#### 二、初次打包

1. 在 AideLua 点击新建项目，在填写与选择完成后点击 `新建`
2. 用 AIDE 打开项目，点击 `构建刷新`，`确定`（或者 `运行` ，`gradle assembleRelease`，推荐这种方法）
3. 点击 AideLua 的 `二次打包并安装` 按钮（或 `二次打包` ，然后手动签名）并安装，测试是否可以正常打包并运行
4. 点击 AideLua 的 `运行` 按钮，测试是否正常通过已安装的应用调试

::: tip
您也可以使用[此工具](tool/alua2aidelua.md)将现有 AndroLua+ 工程转换为 Aide Lua 项目
:::

## 工作原理

1. 读取 `.aidelua/config.lua` 的内容
2. 找到 `app.apk` 的路径，并解压到 `<主模块名称>/build/aidelua_unzip`
3. 将 `<模块名称>/src/main/assets_bin` 等目录中的文件添加到 `aidelua_unzip` 文件夹中，并编译 Lua (编译 Lua 需要启用 `compileLua`)
4. 压缩 `aidelua_unzip` ，并改名为 `<应用名>_v<版本号>.apk`
5. 签名 `<应用名>_v<版本号>.apk` 到 `<应用名>_v<版本号>_sign.apk` (签名 APK 需要选择 `二次打包并安装` 菜单)

## 注意事项

1. AIDE 必须使用 `AIDE高级设置版本` ，否则无法打开 `重定义Apk路径`
2. AIDE 必须打开 `重定义Apk路径` ，否则会导致 APK 错误
3. AIDE 最好关闭 `adrt调试文件`
4. 不是必须用 AIDE 编译，也可以使用 Android Studio 编译

## 开放源代码许可

<https://gitee.com/AideLua/AideLua/blob/master/app/src/main/assets_bin/licences>

## 广告

### MyLuaApp（推荐）（友情推广）

<!--有效期：2022.02.26-永久-->

开源地址：<https://github.com/dingyi222666/MyLuaApp>

MyLuaApp 是一款轻量，快速的安卓软件， 使用Lua和Java 来混合开发安卓软件。

::: tip
Aide Lua 这种工作方式终究不是一个好的解决方案。MyLuaApp 将会取代 Aide Lua
:::

### 更多广告

欢迎投放更多广告（仅限编程开发相关，5元1个月，超时后将不定时删除）！

## 更多资源

[软件素材](./material.md) |
[国际化](./internationalization.md)

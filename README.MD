# WinscopeSetup

中文|[English](README_ENG.MD)

用于独立编译运行 `Winscope` 的（可能是）最小的组件集。

## 所需仓库

+ frameworks/base: https://android.googlesource.com/platform/frameworks/base
+ development: https://android.googlesource.com/platform/development
+ external/perfetto: https://android.googlesource.com/platform/external/perfetto
+ frameworks/proto_logging: https://android.googlesource.com/platform/frameworks/proto_logging
+ frameworks/libs/systemui: https://android.googlesource.com/platform/frameworks/libs/systemuis

## 分支

目前基于 `aosp` 的 `android15-qpr2-release` 分支构建。

## 编译

### 自动编译

使用我提供的[脚本](setup.sh)来直接一键编译。

```bash
./setup.sh
```

### 手动编译

1. 下载上述所有仓库

```bash
git clone -b android15-qpr2-release https://android.googlesource.com/platform/frameworks/base frameworks/base --depth=1
git clone -b android15-qpr2-release https://android.googlesource.com/platform/development development --depth=1
git clone -b android15-qpr2-release https://android.googlesource.com/platform/external/perfetto external/perfetto --depth=1
git clone -b android15-qpr2-release https://android.googlesource.com/platform/frameworks/proto_logging frameworks/proto_logging --depth=1
git clone -b android15-qpr2-release https://android.googlesource.com/platform/frameworks/libs/systemui frameworks/libs/systemui --depth=1
```

2. 进入 `development/tools/winscope` 目录，然后进行编译

```bash
npm install
npm run build:prod
```

## 大功告成

进入 `development/tools/winscope`，运行 `npm run start` 即可启动，同时别忘了启动 `adb proxy`：`python3 src/adb/winscope_proxy.py`。

![screenshot](raw/screenshot.png)
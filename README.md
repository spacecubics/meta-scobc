# meta-scobc

## Prerequisite

> [!IMPORTANT]
> We store `.xsa` files using [Git LFS][1]. Make sure Git LFS is
> installed; otherwise you won't get the actual `.xsa` files and the build
> will fail.

## Setup

We use [`uv`](https://github.com/astral-sh/uv) to manage the Python environment for `kas` and related tooling.

```
$ uv sync
$ source .venv/bin/activate
```

## Build

Builds are managed using [`kas`](https://github.com/siemens/kas).

|Machine|Build command|
|-|-|
|Kria K24 SOM board|`$ kas build kas/xilinx-k24-smk-sdt.yml`|
|SC-OBC Module V1|`$ kas build kas/scobc-v1.yml`|

Example:
```
$ kas build kas/scobc-v1.yml
```

The resulting images will be available under:
```
build/tmp/deploy/images/<machine>/
```

### Faster builds (shared caches)

For faster incremental builds, you can enable shared download and sstate caches:
```
$ kas build kas/xilinx-k24-smk-sdt.yml:kas/conf/site.opt.yml
```

---

[1]: https://git-lfs.com/

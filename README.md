# meta-scobc

## Prerequisite

> [!IMPORTANT]
> We store `.xsa` files using [Git LFS][1]. Make sure Git LFS is
> installed; otherwise you won't get the actual `.xsa` files and the build
> will fail.

## Setup

We use [`uv`](https://github.com/astral-sh/uv) to manage the Python environment for `kas` and related tooling.

```bash
$ uv sync
$ source .venv/bin/activate
```

## Build

Builds are managed using [`kas`](https://github.com/siemens/kas).

### Build command

To build a machine:

```bash
$ kas build <kas configuration file>
```

Example:

```bash
$ kas build kas/scobc-v1-sdt.yml
```

The resulting images will be available under:

```bash
build/tmp/deploy/images/<machine>/
```

### Supported Machines

| Machine                          | Machine configuration file                       | kas configuration file                      |
| -------------------------------- | -------------------------------------------------| ------------------------------------------- |
| SC-OBC Module V1 Space Grade     | [`versal-scobc-v1-sdt-full`][m-space]            | [`kas/scobc-v1-sdt.yml`][kas-space]         |
| SC-OBC Module V1 Developer Grade | [`versal-scobc-v1-ve2302e-sdt-full`][m-dev-2302] | [`kas/scobc-v1-devgrade.yml`][kas-dev-2302] |
| SC-OBC Module V1 VE2002 Variant  | [`versal-scobc-v1-ve2002e-sdt-full`][m-dev-2002] | [`kas/scobc-v1-devgrade-ve2002.yml`][kas-dev-2002] |

> [!NOTE]
> SC-OBC Module V1 VE2002 Variant is not
> commercially available.

### Faster builds (shared caches)

For faster incremental builds, you can enable shared download and sstate caches:

```bash
$ kas build kas/scobc-v1-sdt.yml:kas/conf/site.opt.yml
```

---

[1]: https://git-lfs.com/
[m-space]: meta-scobc-v1/conf/machine/versal-scobc-v1-sdt-full.conf
[m-dev-2302]: meta-scobc-v1/conf/machine/versal-scobc-v1-ve2302e-sdt-full.conf
[m-dev-2002]: meta-scobc-v1/conf/machine/versal-scobc-v1-ve2002e-sdt-full.conf
[kas-space]: kas/scobc-v1-sdt.yml
[kas-dev-2302]: kas/scobc-v1-devgrade.yml
[kas-dev-2002]: kas/scobc-v1-devgrade-ve2002.yml

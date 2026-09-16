# meta-scobc

## Prerequisite

> [!IMPORTANT]
> If you need to check out or build sources at or before
> [v2026.06][tag-v2026.06], [Git LFS][git-lfs] must be installed; otherwise
> you won't get the actual `.xsa` files and the build will fail.

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
$ kas build kas/scobc-v1.yml
```

The resulting images will be available under:

```bash
build/tmp/deploy/images/<machine>/
```

### Supported Machines

| Machine | Board revision | Machine configuration file | kas configuration file |
| --- | --- | --- | --- |
| SC-OBC Module V1 Space Grade | Rev.B and later | [`versal-scobc-v1-ve2302i-revb-sdt-full`][m-space-revb] | [`kas/scobc-v1.yml`][kas-space-revb] |
| SC-OBC Module V1 Space Grade | Rev.A | [`versal-scobc-v1-ve2302i-reva-sdt-full`][m-space-reva] | [`kas/scobc-v1-reva.yml`][kas-space-reva] |
| SC-OBC Module V1 Developer Grade | Rev.B and later | [`versal-scobc-v1-ve2302e-revb-sdt-full`][m-dev-2302-revb] | [`kas/scobc-v1-devgrade.yml`][kas-dev-2302-revb] |
| SC-OBC Module V1 Developer Grade | Rev.A | [`versal-scobc-v1-ve2302e-reva-sdt-full`][m-dev-2302-reva] | [`kas/scobc-v1-devgrade-reva.yml`][kas-dev-2302-reva] |
| SC-OBC Module V1 VE2002 Variant | Rev.B and later | [`versal-scobc-v1-ve2002e-revb-sdt-full`][m-dev-2002-revb] | [`kas/scobc-v1-devgrade-ve2002.yml`][kas-dev-2002-revb] |
| SC-OBC Module V1 VE2002 Variant | Rev.A | [`versal-scobc-v1-ve2002e-reva-sdt-full`][m-dev-2002-reva] | [`kas/scobc-v1-devgrade-ve2002-reva.yml`][kas-dev-2002-reva] |

> [!NOTE]
> SC-OBC Module V1 VE2002 Variant is not
> commercially available.

### Faster builds (shared caches)

For faster incremental builds, you should keep the downloaded files and
the shared state cache. By default, the download directory and the
shared state directory are placed under the build directory. This means
that when you remove the build directory, those artifacts are removed as
well.

Instead, set the `DL_DIR` and `SSTATE_DIR` environment variables to
fixed locations outside the build directory. This keeps the artifacts
available even if you delete and recreate the build directory.

```console
$ export DL_DIR=/opt/yocto/downloads
$ export SSTATE_DIR=/opt/yocto/sstate-cache
$ kas build kas/scobc-v1.yml
```

[tag-v2026.06]: https://github.com/spacecubics/meta-scobc/commits/v2026.06
[git-lfs]: https://git-lfs.com/
[m-space-revb]: meta-scobc/conf/machine/versal-scobc-v1-ve2302i-revb-sdt-full.conf
[m-space-reva]: meta-scobc/conf/machine/versal-scobc-v1-ve2302i-reva-sdt-full.conf
[m-dev-2302-revb]: meta-scobc/conf/machine/versal-scobc-v1-ve2302e-revb-sdt-full.conf
[m-dev-2302-reva]: meta-scobc/conf/machine/versal-scobc-v1-ve2302e-reva-sdt-full.conf
[m-dev-2002-revb]: meta-scobc/conf/machine/versal-scobc-v1-ve2002e-revb-sdt-full.conf
[m-dev-2002-reva]: meta-scobc/conf/machine/versal-scobc-v1-ve2002e-reva-sdt-full.conf
[kas-space-revb]: kas/scobc-v1.yml
[kas-space-reva]: kas/scobc-v1-reva.yml
[kas-dev-2302-revb]: kas/scobc-v1-devgrade.yml
[kas-dev-2302-reva]: kas/scobc-v1-devgrade-reva.yml
[kas-dev-2002-revb]: kas/scobc-v1-devgrade-ve2002.yml
[kas-dev-2002-reva]: kas/scobc-v1-devgrade-ve2002-reva.yml

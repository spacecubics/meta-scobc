# Build Guide

This document describes how to build images using [`kas`][kas].

## Prerequisite

> [!IMPORTANT]
> We store `.xsa` files using [Git LFS][git-lfs]. Make sure Git LFS is
> installed; otherwise you won't get the actual `.xsa` files and the build
> will fail.

## Host dependencies (Ubuntu)

The following packages are required on Ubuntu-based systems.

### Install `libncurses5` and `libtinfo5`

Some tools still depend on `libncurses5` and `libtinfo5`, which are no longer
available in recent Ubuntu releases. These packages can be installed from the
Ubuntu 22.04 (Jammy) repository.

Create a temporary source list:

```bash
sudo cp scripts/jammy.sources /etc/apt/sources.list.d/
```

Install the packages:

```bash
sudo apt update
sudo apt install libncurses5 libtinfo5
```

Remove the temporary repository entry:

```bash
sudo rm /etc/apt/sources.list.d/jammy.sources
```

### Install required packages

```bash
sudo apt install build-essential debianutils binutils chrpath cpio \
    diffstat file g++ gawk gcc git git-lfs lz4 make socat texinfo unzip \
    wget xz-utils python3 python3-git python3-jinja2 python3-pexpect \
    python3-pip python3-subunit python3-yaml rpcsvc-proto zstd iputils-ping \
    libacl1 liblz4-tool locales
```

## Setup

### Install `uv`

We use [`uv`][uv] to manage the Python environment.

Install `uv`:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### Install dependencies

Install the Python dependencies defined in `pyproject.toml`:

```bash
uv sync --locked
```

This installs the exact dependency versions recorded in `uv.lock`.

## Build

Builds are managed using [`kas`][kas].

Example:

```bash
uv run kas build kas/<kas-configuration-file>
```

The resulting images will be available under:

```text
build/tmp/deploy/images/<machine-name>/
```

The available `<machine-name>` and
corresponding `<kas-configuration-file>` are documented in:

- [Machine Overview](/docs/machines/README.md)

### Optional: activate the virtual environment

If you prefer using `kas` directly instead of `uv run`,
you can activate the virtual environment:

```bash
source .venv/bin/activate
```

After activation, `kas` can be used directly:

```bash
kas build kas/<kas-configuration-file>
```

## Writing the image to an SD card

Images can be written to an SD card using `bmaptool`.

Example:

```bash
bmaptool copy \
    build/tmp/deploy/images/<machine-name>/<image>.wic \
    /dev/sdX
```

> [!info]
> Replace `/dev/sdX` with the correct device.

`bmaptool` automatically uses the `.wic.bmap` file if available,
which significantly speeds up the flashing process.

## Faster builds (shared caches)

Yocto downloads and build artifacts can be shared between builds
to significantly reduce build time.

This can be configured using environment variables.

Example:

```bash
export DL_DIR=/opt/yocto/downloads
export SSTATE_DIR=/opt/yocto/sstate-cache

uv run kas build kas/<kas-configuration-file>
```

## Using multiple kas configuration files

`kas` supports stacking multiple configuration files.

Syntax:

```bash
kas build <kas-file1>:<kas-file2>:...
```

Each configuration file can override variables defined in previous files.
Later files take precedence.

Example:

```bash
uv run kas build kas/<kas-configuration-file>:kas/conf/site.opt.yml
```

This is commonly used for:

- local build configuration
- cache configuration
- developer-specific overrides

[git-lfs]: https://git-lfs.com/
[kas]: https://github.com/siemens/kas
[uv]: https://github.com/astral-sh/uv

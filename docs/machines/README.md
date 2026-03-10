# Machines Overview

This directory documents machines supported by `meta-scobc`.

## Available platforms

| Platform              | Description |
| --------------------- | ----------- |
| [SC-OBC V1][scobc-v1] | wip         |

## Machine name format

Machine configuration names follow this format:

```text
<soc>-<platform>-<variant>-<flow>-<feature>
```

### Components

| Component  | Description                                     |
| ---------- | ----------------------------------------------- |
| `soc`      | SoC family                                      |
| `platform` | SC-OBC platform generation (e.g. `scobc-v1`)    |
| `variant`  | Hardware variant (e.g. `ve2302e`, `ve2002e`)    |
| `flow`     | Build flow (`sdt` or `xsct`)                    |
| `feature`  | PL overlay generation mode (e.g. `full`, `dfx`) |

### Variant naming

The `variant` component represents the target hardware configuration.

Currently, it is composed of:

```text
<processor><suffix>
```

Examples:

- `ve2302e`
- `ve2002e`

Where:

| Part               | Description                          |
| ------------------ | ------------------------------------ |
| `ve2302`, `ve2002` | Versal processor model               |
| `e`                | Engineering / developer-grade device |
| `i`                | Industrial-grade device              |

Developer-grade boards typically use engineering devices (`e`).

### Build flows

The `flow` component specifies the build flow used to generate the platform.

Available flows:

| Flow   | Description                                |
| ------ | ------------------------------------------ |
| `sdt`  | Uses the **System Device Tree (SDT)** flow |
| `xsct` | Uses the **XSCT-based flow** (deprecated)  |

The XSCT flow is kept for compatibility but is considered deprecated.

### PL overlay modes

The `feature` suffix corresponds to the PL overlay generation mode
selected via the `gen-machine-conf` option.

Available modes:

| Mode   | Description                                                      |
| ------ | ---------------------------------------------------------------- |
| `full` | Generate device tree overlay for the full PL design              |
| `dfx`  | Generate device tree overlay for Dynamic Function eXchange (DFX) |

[scobc-v1]: scobc-v1.md

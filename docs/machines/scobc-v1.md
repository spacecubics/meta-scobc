# SC-OBC V1

SC-OBC V1 is the on-board computer developed by Space Cubics.

## Variants

| Variant        | Processor | Description |
| -------------- | --------- | ----------- |
| SpaceGrade     | VE2302    | wip         |
| DeveloperGrade | VE2302    | wip         |
| DeveloperGrade | VE2002    | wip         |

## Build configurations

### SDT flow

| Machine                                  | Machine configuration file                                                                             | kas configuration file                                                 |
| ---------------------------------------- | ------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------- |
| SC-OBC Module V1 SpaceGrade              | [`versal-scobc-v1-ve2302i-sdt-full`](meta-scobc-v1/conf/machine/versal-scobc-v1-ve2302i-sdt-full.conf) | [`kas/scobc-v1.yml`](kas/scobc-v1.yml)                                 |
| SC-OBC Module V1 DeveloperGrade (VE2302) | [`versal-scobc-v1-ve2302e-sdt-full`](meta-scobc-v1/conf/machine/versal-scobc-v1-ve2302e-sdt-full.conf) | [`kas/scobc-v1-devgrade.yml`](kas/scobc-v1-devgrade.yml)               |
| SC-OBC Module V1 DeveloperGrade (VE2002) | [`versal-scobc-v1-ve2002e-sdt-full`](meta-scobc-v1/conf/machine/versal-scobc-v1-ve2002e-sdt-full.conf) | [`kas/scobc-v1-devgrade-ve2002.yml`](kas/scobc-v1-devgrade-ve2002.yml) |

### XSCT flow (deprecated)

| Machine                                  | Machine configuration file                                                                               | kas configuration file                                                           |
| ---------------------------------------- | -------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- |
| SC-OBC Module V1 SpaceGrade              | [`versal-scobc-v1-ve2302i-xsct-full`](meta-scobc-v1/conf/machine/versal-scobc-v1-ve2302i-xsct-full.conf) | [`kas/scobc-v1-xsct.yml`](kas/scobc-v1-xsct.yml)                                 |
| SC-OBC Module V1 DeveloperGrade (VE2302) | [`versal-scobc-v1-ve2302e-xsct-full`](meta-scobc-v1/conf/machine/versal-scobc-v1-ve2302e-xsct-full.conf) | [`kas/scobc-v1-devgrade-xsct.yml`](kas/scobc-v1-devgrade-xsct.yml)               |
| SC-OBC Module V1 DeveloperGrade (VE2002) | [`versal-scobc-v1-ve2002e-xsct-full`](meta-scobc-v1/conf/machine/versal-scobc-v1-ve2002e-xsct-full.conf) | [`kas/scobc-v1-devgrade-ve2002-xsct.yml`](kas/scobc-v1-devgrade-ve2002-xsct.yml) |

### Dualboot

SC-OBC V1 supports a dualboot configuration that allows the system
to switch between two bootable system images. This mechanism enables
robust on-the-air updates and recovery from failed updates.

The dualboot configuration is built using dedicated `kas`
configuration files.

| Machine                                          | Machine configuration file                                                                             | kas configuration file                                             |
| ------------------------------------------------ | ------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------ |
| SC-OBC Module V1 SpaceGrade                      | [`versal-scobc-v1-ve2302i-sdt-full`](meta-scobc-v1/conf/machine/versal-scobc-v1-ve2302i-sdt-full.conf) | [`kas/scobc-v1-dualboot.yml`](kas/scobc-v1-dualboot.yml)           |
| SC-OBC Module V1 SpaceGrade (update bundle only) | [`versal-scobc-v1-ve2302i-sdt-full`](meta-scobc-v1/conf/machine/versal-scobc-v1-ve2302i-sdt-full.conf) | [`kas/scobc-v1-update-bundle.yml`](kas/scobc-v1-update-bundle.yml) |

For details about the dualboot mechanism, see:

- [Dualboot documentation](docs/dualboot.md)

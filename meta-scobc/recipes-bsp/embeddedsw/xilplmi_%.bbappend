# Include the PLM NVM handlers so Linux can read the device DNA via nvmem.
# Use minimal logging to leave room for the NVM code in the 384 KiB PPU RAM.
EXTRA_OECMAKE:append:scobc-v1-generic = " \
    -DXILPLMI_plm_nvm_en=ON \
    -DXILPLMI_plm_dbg_lvl=level0 \
"

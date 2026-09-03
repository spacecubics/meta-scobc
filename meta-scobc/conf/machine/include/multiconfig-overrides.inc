# Add the selected tune override only for multiconfig builds.
MACHINEOVERRIDES =. "${@d.getVar('DEFAULTTUNE') + ':' if d.getVar('BB_CURRENT_MC') != 'default' else ''}"

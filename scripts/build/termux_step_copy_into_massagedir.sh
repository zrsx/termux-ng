termux_step_copy_into_massagedir() {
    local DEST="$TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX_CLASSICAL"
    mkdir -p "$DEST"
    echo "$TERMUX_PREFIX_CLASSICAL"
    ls -1 "$TERMUX_PREFIX_CLASSICAL"
    tar -C "$TERMUX_PREFIX_CLASSICAL" \
        --exclude='tmp' \
        --exclude='__pycache__' \
        -cf - . | tar -C "$DEST" -xf -
}

termux_step_copy_into_massagedir() {
	local DEST="$TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX_CLASSICAL"
	local SRC="$TERMUX_PREFIX_CLASSICAL"

	mkdir -p "$DEST"

	# Copy only files installed or modified by current package build.
	# This avoids leaking dependency files already present in shared prefix.
	find "$SRC" -mindepth 1 \
		-newer "$TERMUX_BUILD_TS_FILE" \
		! -path "$SRC/tmp/*" \
		! -path "$SRC/__pycache__/*" \
		-print0 | while IFS= read -r -d '' file; do
		local rel="${file#$SRC/}"

		if [ -d "$file" ]; then
			mkdir -p "$DEST/$rel"
		elif [ -L "$file" ]; then
			mkdir -p "$DEST/$(dirname "$rel")"
			cp -a "$file" "$DEST/$rel"
		elif [ -f "$file" ]; then
			mkdir -p "$DEST/$(dirname "$rel")"
			cp -a "$file" "$DEST/$rel"
		fi
	done
}

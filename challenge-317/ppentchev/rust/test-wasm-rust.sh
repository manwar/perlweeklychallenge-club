#!/bin/sh

set -e
set -x

: "${CARGO:=cargo}"
: "${WAC:=wac}"
: "${WASMTIME:=wasmtime}"

usage() {
	cat <<'EOUSAGE'
Usage:  test-wasm-rust
EOUSAGE
}

run() {
	local targetdir='target' mode='release' target='wasm32-wasip1'
	local output="$targetdir/$target/$mode"

	[ -n "$NOCLEAN" ] || "${CARGO}" component clean
	if [ -h "$targetdir" ] || [ -e "$targetdir" ]; then
		echo "Did not expect $targetdir to exist" 1>&2
		exit 1
	fi

	"${CARGO}" component build "--$mode"
	if [ ! -d "$output" ]; then
		echo "Expected $output to exist by now" 1>&2
		exit 1
	fi

	"${WAC}" plug \
		-o "$output/test-acronyms-rust.wasm" \
		--plug "$output/wasm_acronyms.wasm" \
		-- \
		"$output/wasm-test-acronyms.wasm"

	"${WASMTIME}" -- "$output/test-acronyms-rust.wasm"

	"${WAC}" plug \
		-o "$output/test-frings-rust.wasm" \
		--plug "$output/wasm_frings.wasm" \
		-- \
		"$output/wasm-test-frings.wasm"

	"${WASMTIME}" -- "$output/test-frings-rust.wasm"
}

if [ "$#" -gt 0 ]; then
	usage 1>&2
	exit 1
fi

run

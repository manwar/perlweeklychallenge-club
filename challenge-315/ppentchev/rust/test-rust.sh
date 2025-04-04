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
		-o "$output/test_find_words_rust.wasm" \
		--plug "$output/wasm_find_words.wasm" \
		-- \
		"$output/wasm_test_find_words.wasm"

	"${WASMTIME}" -- "$output/test_find_words_rust.wasm"

	"${WAC}" plug \
		-o "$output/test_find_third_rust.wasm" \
		--plug "$output/wasm_find_third.wasm" \
		-- \
		"$output/wasm_test_find_third.wasm"

	"${WASMTIME}" -- "$output/test_find_third_rust.wasm"

	# ./run-clippy.sh -c "$CARGO" -n
}

if [ "$#" -gt 0 ]; then
	usage 1>&2
	exit 1
fi

run

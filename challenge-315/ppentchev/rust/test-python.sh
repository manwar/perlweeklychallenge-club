#!/bin/sh

set -e
set -x

: "${CARGO:=cargo}"
: "${UVOXEN:=uvoxen}"
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

	cd ../python
	rm -rf -- src/wasm_find_third_bindings src/wasm_find_words_bindings wasm

	"${UVOXEN}" uv run

	"${UVOXEN}" uv run -e wasm-bindings
	if [ -h wasm ] || [ -e wasm ]; then
		echo "Did not expect wasm to exist" 1>&2
		exit 1
	fi
	if [ ! -d src/wasm_find_words_bindings ]; then
		echo "Expected src/wasm_find_words_bindings to be a directory" 1>&2
		exit 1
	fi
	if [ ! -d src/wasm_find_third_bindings ]; then
		echo "Expected src/wasm_find_third_bindings to be a directory" 1>&2
		exit 1
	fi

        mkdir wasm
	"${UVOXEN}" uv run -e wasm-componentize
	if [ ! -f wasm/wasm_find_words.wasm ]; then
		echo "Expected wasm/wasm_find_words.wasm to be a file" 1>&2
		exit 1
	fi
	if [ ! -f wasm/wasm_find_third.wasm ]; then
		echo "Expected wasm/wasm_find_third.wasm to be a file" 1>&2
		exit 1
	fi

	cd ../rust
	"${WAC}" plug \
		-o "$output/test_find_words_python.wasm" \
		--plug "../python/wasm/wasm_find_words.wasm" \
		-- \
		"$output/wasm_test_find_words.wasm"

	"${WASMTIME}" -- "$output/test_find_words_python.wasm"

	"${WAC}" plug \
		-o "$output/test_find_third_python.wasm" \
		--plug "../python/wasm/wasm_find_third.wasm" \
		-- \
		"$output/wasm_test_find_third.wasm"

	"${WASMTIME}" -- "$output/test_find_third_python.wasm"
}

if [ "$#" -gt 0 ]; then
	usage 1>&2
	exit 1
fi

run

#!/bin/fish
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

function decode_xor
    set -f encoded (string split ' ' $argv[1])
    set -f current $argv[2]
    set -f result $current

    set -f enc
    for enc in $encoded
        set current (math bitxor $current, $enc)
        set -a result $current
    end

    printf '%s\n' (string join ' ' $result)
end

function test_decode_xor
    decode_xor '1 2 3' 1
    decode_xor '6 2 7 3' 4
end

test_decode_xor

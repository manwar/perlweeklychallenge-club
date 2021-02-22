#!/usr/bin/env raku

use v6.d;

# readN takes a file & returns the first `$chars' characters if called
# the first time. It stores the pointer index & returns characters
# from `$idx' to `$idx + $chars'.
sub readN (
    IO $file, Int $chars --> Str
) {
    # %pointers stores the pointer index.
    state Int %pointers;
    %pointers{$file} = 0 without %pointers{$file};

    with %pointers{$file} -> $idx {
        %pointers{$file} += $chars;
        return $file.slurp.substr($idx, $chars);
    }
}

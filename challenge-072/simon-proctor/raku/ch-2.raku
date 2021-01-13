#!/usr/bin/env raku

use v6;

subset FilePath of Str where *.IO:f;

#| Read and output lines A -> B in the given text file
sub MAIN (
    UInt $A where * > 0, #= Start line
    UInt $B where * >= $A, #= End line
    FilePath :f(:$file) = "test-file.txt", #= Text file to read
) {
    .say for $file.IO.lines[$A-1..$B-1];
}

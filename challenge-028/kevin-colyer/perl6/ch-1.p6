#!/usr/bin/perl6
use v6;

use Test;

# 28.1 Write a script to check the file content without explicitly reading the content. It should accept file name with path as command line argument and print “The file content is binary.” or else “The file content is ascii.” accordingly.

sub MAIN(Str $file where *.IO.e) {
    my $fh = $file.IO.open;
    LEAVE try close $fh;

    # attempt a single byte read explicitly in ascii
    $fh.encoding: 'ascii';

    try {
        $fh.getc;
    }
    if $! { say “The file content is binary.”}
    else  { say “The file content is ascii.” };
}

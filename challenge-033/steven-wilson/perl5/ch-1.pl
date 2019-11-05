#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-11-05
# Week: 033

# Task #1
# Count Letters (A..Z)
# Create a script that accepts one or more files specified on the command-line and count the number of times letters appeared in the files.
# So with the following input file sample.txt
# The quick brown fox jumps over the lazy dog.
# the script would display something like:
# a: 1
# b: 1
# c: 1
# ...
# x: 1
# y: 1
# z: 1

use strict;
use warnings;
use feature qw/ say /;

my @files = @ARGV;
my %letters_count;

for my $file (@files) {
    open my $fh, '<', $file or die "Can't open < $file: $!";
    while ( !eof $fh ) {
        my @letters = grep {/[[:alpha:]]/} split //, readline($fh);
        for my $letter (@letters) {
            $letters_count{ lc $letter } += 1;
        }
    }
    close $fh;
}

for my $letter ( sort keys %letters_count ) {
    say "$letter: $letters_count{$letter}";
}

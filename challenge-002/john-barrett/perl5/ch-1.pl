#!/usr/bin/env perl

# ./ch-1.pl 00123

$ARGV[0] > 0 && printf (
    ( $ARGV[0] =~ /\./
        ? "%g\n"
        : "%d\n" ), $ARGV[0]
);

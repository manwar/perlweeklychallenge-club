#!/usr/bin/perl
use 5.010;
use warnings;
use strict;
use English qw/ -no_match_vars /;

if (scalar @ARGV != 1) {
    die "$PROGRAM_NAME variable-name\n";
}

$$ARGV[0] = 42;

say "$ARGV[0] = $$ARGV[0]";

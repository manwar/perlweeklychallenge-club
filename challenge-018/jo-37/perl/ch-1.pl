#!/usr/bin/perl

use v5.16;
use warnings;
use String::LCSS_XS 'lcss';

die <<EOS unless @ARGV > 1;
usage: $0 STR1 STR2...

STR1 STR2...
    some strings

EOS


main: {
    my $longest = shift;
    $longest = lcss($longest, shift) while @ARGV;
    say $longest;
}

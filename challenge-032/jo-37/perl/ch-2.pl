#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Util 'max';
use experimental 'signatures';

our $values;

die <<EOS unless @ARGV;
usage: $0 [-values] [--] FILE...

-values
    present items sorted by value instead of label

FILE...
    names of files containing label-value pairs. Use '-' for STDIN.

EOS


### Input and Output

{
    local $/;
    use warnings FATAL => 'misc';
    say chart({split /\s+/, <>}, $values ? 2 : 1);
}


### Implementation

sub chart ($data, $sort) {
    my @sorted = sort {$sort == 1 ? $a->[0] cmp $b->[0] : $a->[1] <=> $b->[1]}
        map [$_, $data->{$_}], keys %$data;
    my $maxlen = max map length, keys %$data;
    my $maxvalue = max values %$data;
    my $scale = int +(77 - $maxlen) / $maxvalue;
    printf "%*s | %s\n", $maxlen, $_->[0], '#' x ($_->[1] * $scale) for @sorted;
}

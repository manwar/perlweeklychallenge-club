#!/usr/bin/perl
use v5.38;
use builtin qw/ true false /;
no warnings 'experimental::builtin';

my @list = @ARGV;
my $circular = true;

for my $i (1 .. scalar @list - 1) {
    if (substr($list[$i], 0, 1) ne substr($list[$i - 1], -1, 1)) {
        $circular = false;
        last;
    }
}

say $circular ? 'true' : 'false';

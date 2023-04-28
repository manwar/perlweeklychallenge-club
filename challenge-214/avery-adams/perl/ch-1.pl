#!/usr/bin/perl

use strict;
use v5.24;

my @sorted = reverse sort @ARGV;
my %hash;
my @table = ('G', 'S', 'B');
my $curr;

foreach (@sorted) {
    if ($curr <= 2) {
        $hash{$_} //= $table[$curr];
    } else {
        $hash{$_} //= $curr + 1;
    }
    $curr++;
}

say $hash{$_} for @ARGV;

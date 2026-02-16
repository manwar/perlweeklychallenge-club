#!/usr/bin/env perl

use Modern::Perl;

my @nums = split ' ', <>;
my($rows, $cols) = split ' ', <>;
my @m;
for my $r (0 .. $rows-1) {
    $m[$r] = [];
    for my $c (0 .. $cols-1) {
        $m[$r][$c] = shift @nums;
    }
}
say join ", ", map {"[$_]"} map {join ", ", @$_} @m;

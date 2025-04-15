#!/usr/bin/perl
use v5.38;

my @list = map { [split //, $_] } @ARGV;
my @cols;

for my $row (keys @list) {
    for my $col (keys @{$list[$row]}) {
        $cols[$col] .= $list[$row]->[$col];
    }
}

say scalar grep { $_ ne join q{}, sort split //, $_ } @cols;

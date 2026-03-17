#!/usr/bin/env perl

use Modern::Perl;

my @words = @ARGV;
my $count = 0;
for my $i (0 .. $#words-1) {
    for my $j ($i+1 .. $#words) {
        $count++ if is_pair($words[$i], $words[$j]);
    }
}
say $count;


sub is_pair {
    my($a, $b) = @_;
    return $a eq join '', reverse split //, $b;
}

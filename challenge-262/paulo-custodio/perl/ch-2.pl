#!/usr/bin/env perl

use Modern::Perl;

my($k, @ints) = @ARGV;
say count_pairs($k, @ints);

sub count_pairs {
    my($k, @ints) = @_;
    my $count = 0;
    for my $i (0 .. $#ints-1) {
        for my $j ($i+1 .. $#ints) {
            $count++ if $ints[$i] == $ints[$j] && ($i*$j) % $k == 0;
        }
    }
    return $count;
}

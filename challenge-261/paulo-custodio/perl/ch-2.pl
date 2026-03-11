#!/usr/bin/env perl

use Modern::Perl;

my($start, @ints) = @ARGV;
say mult_two($start, @ints);

sub mult_two {
    my($n, @ints) = @_;
    while (grep {$_ == $n} @ints) {
        $n *= 2;
    }
    return $n;
}

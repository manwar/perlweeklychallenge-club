#!/usr/bin/env perl

# Perl Weekly Challenge 173 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-173/

use Modern::Perl;

sub is_esthetic {
    my($n) = @_;
    my @n = split //, $n;
    while (@n > 1) {
        return 0 if abs($n[0] - $n[1]) != 1;
        shift @n;
    }
    return 1;
}

@ARGV==1 or die "usage: ch-1.pl n\n";
say is_esthetic(shift);

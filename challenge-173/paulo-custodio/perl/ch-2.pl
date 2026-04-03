#!/usr/bin/env perl

# Perl Weekly Challenge 173 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-173/

use Modern::Perl;

sub sylvester_seq {
    my($N) = @_;
    my @n = (2);
    my $prod = 2;
    while (@n < $N) {
        my $term = $prod+1;
        push @n, $term;
        $prod *= $term;
    }
    return @n;
}

@ARGV==1 or die "usage: ch-2.pl n\n";
say "(", join(", ", sylvester_seq(shift)), ")";

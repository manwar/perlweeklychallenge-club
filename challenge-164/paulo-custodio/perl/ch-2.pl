#!/usr/bin/env perl

# Perl Weekly Challenge 164 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-164/

use Modern::Perl;
use List::Util 'sum';

sub is_happy {
    my($n)=@_;
    my %seen;
    while ($n!=1) {
        return 0 if $seen{$n}++;
        $n=sum(map {$_*$_} split //, $n);
    }
    return 1;
}

sub happy_numbers {
    my($n)=@_;
    my @happy;
    for (my $i=1; @happy<$n; $i++) {
        push @happy,$i if is_happy($i);
    }
    return @happy;
}

say "(", join(", ", happy_numbers(shift)), ")";

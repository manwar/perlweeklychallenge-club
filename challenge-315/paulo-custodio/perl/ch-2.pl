#!/usr/bin/env perl

# Perl Weekly Challenge 315 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-315/

use Modern::Perl;

my @words = split /\W+/, <>;
chomp(my $first = <>);
chomp(my $second = <>);

say "(", join(", ", find_third($first, $second, @words)), ")";

sub find_third {
    my($first, $second, @words) = @_;
    my @third;
    for my $i (0 .. $#words-2) {
        if ($words[$i] eq $first && $words[$i+1] eq $second) {
            push @third, $words[$i+2];
        }
    }
    return @third;
}

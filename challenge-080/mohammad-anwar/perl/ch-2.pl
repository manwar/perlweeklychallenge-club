#!/usr/bin/perl

#
# Perl Weekly Challenge - 080
#
# Task #2: Count Candies
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-080
#

use strict;
use warnings;
use List::Util qw(max);

my $C = $ARGV[0] || "1, 5, 2, 1";
printf("Total candies: %d\n", count_candies(get_rankings($C)));

#
#
# METHODS

sub count_candies {
    my ($rankings) = @_;

    my $l2r = [];
    my $r2l = [];

    push @$l2r, 1 for @$rankings;
    push @$r2l, 1 for @$rankings;

    my $i = 1;
    while ($i <= $#$rankings) {
        $l2r->[$i] = $l2r->[$i - 1] + 1
               if ($rankings->[$i] > $rankings->[$i - 1]);
        $i++
    }

    my $j = $#$rankings - 1;
    while ($j >= 0) {
        $r2l->[$j] = $r2l->[$j + 1] + 1
            if ($rankings->[$j] > $rankings->[$j + 1]);
        $j--;
    }

    my $count = 0;
    $count += max($l2r->[$_], $r2l->[$_]) for (0 .. $#$rankings);

    return $count;
}

sub get_rankings {
    my ($c) = @_;

    die "ERROR: Missing rankings.\n"      unless defined $c;
    die "ERROR: Invalid rankings [$c].\n" unless ($c =~ /^[\d\,?\s?]+$/);

    $c =~ s/\s//g;
    return [ split /\,/, $c ];
}

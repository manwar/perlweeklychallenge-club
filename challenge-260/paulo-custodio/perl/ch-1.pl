#!/usr/bin/env perl

# Perl Weekly Challenge 260 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-260/

use Modern::Perl;

my @ints = @ARGV;
say uniq_occurences(@ints);

sub uniq_occurences {
    my(@ints) = @_;
    my %count;
    $count{$_}++ for @ints;
    my %uniq;
    for (values %count) {
        return 0 if $uniq{$_}++;
    }
    return 1;
}

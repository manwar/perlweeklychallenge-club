#!/usr/bin/perl

#
# Perl Weekly Challenge - 080
#
# Task #1: Smallest Positive Number
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-080
#

use strict;
use warnings;

my $N = $ARGV[0] || "2, 3, 7, 6, 8, -1, -10, 15";
printf("%s => %d\n", $N, smallest_positive_number(get_list($N)));

#
#
# SUBROUTINES

sub smallest_positive_number {
    my ($arrayref) = @_;

    my @positive_numbers = sort(grep $_ > 0, @$arrayref);
    return 1 unless (@positive_numbers);

    my $i = 0;
    for my $n (1 .. $positive_numbers[-1]) {
        return $n if ($n < $positive_numbers[$i++]);
    }

    return ++$positive_numbers[-1];
}

sub get_list {
    my ($l) = @_;

    die "ERROR: Missing list.\n"      unless defined $l;
    die "ERROR: Invalid list [$l].\n" unless ($l =~ /^[\-?\d\,?\s?]+$/);

    $l =~ s/\s//g;
    return [ split /\,/, $l ];
}

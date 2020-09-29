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
use Data::Dumper;

my $N = $ARGV[0] || "2, 3, 7, 6, 8, -1, -10, 15";
printf("%s => %d\n", $N, smallest_positive_number(get_list($N)));

#
#
# METHODS

sub smallest_positive_number {
    my ($array) = @_;

    my %numbers = ();
    foreach my $n (@$array) {
        next unless $n > 0;
        $numbers{$n} = 1;
    }

    my $i = 0;
    foreach my $j (sort {$a <=> $b} keys %numbers) {
        next if (++$i == $j);
        return $i;
    }

    return ++$i;
}

sub get_list {
    my ($l) = @_;

    die "ERROR: Missing list.\n"      unless defined $l;
    die "ERROR: Invalid list [$l].\n" unless ($l =~ /^[\-?\d\,?\s?]+$/);

    $l =~ s/\s//g;
    return [ split /\,/, $l ];
}

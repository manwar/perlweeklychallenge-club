#!/usr/bin/perl

#
# Perl Weekly Challenge - 073
#
# Task #2: Smallest Neighbour
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-073
#

package SmallestNeighbour;

use Moo;
use List::Util qw(min);

sub fetch {
    my ($self, $list) = @_;

    die "ERROR: Missing list.\n"
        unless defined $list;
    die "ERROR: Invalid list [$list].\n"
        unless ($list =~ /^[\s?\-?\d\,?\s?]+$/);

    $list =~ s/\s//g;
    $list = [ split /\,/, $list ];

    my @smallest_neighbour = (0);
    foreach my $i (1 .. $#$list) {
        my $min = min( map { $list->[$_] } 0..$i-1 );
        push @smallest_neighbour, ($min < $list->[$i])?($min):(0);
    }

    return \@smallest_neighbour;
}

package main;

use Test2::V0 -target => 'SmallestNeighbour';

my %test_cases = (
    "7,  8, 3, 12, 10" => "0, 7, 0, 3, 3",
    "0,  1, 5,  2,  3" => "0, 0, 0, 0, 0",
    "1, -2, 7,  5, -4" => "0, 0, -2, -2, 0",
);

foreach my $list (sort keys %test_cases) {
    my $min = join ", ", @{$CLASS->fetch($list)};
    is $min, $test_cases{$list}, "testing list $list";
}

done_testing;

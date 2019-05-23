#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-05-22
# Challenge #2
# Write a script to perform different types of ranking as described below:
# 1. Standard Ranking (1224): Items that compare equal receive the
# same ranking number, and then a gap is left in the ranking numbers.
# 2. Modified Ranking (1334): It is done by leaving the gaps in the
# ranking numbers before the sets of equal-ranking items.
# 3. Dense Ranking    (1223): Items that compare equally receive the
# same ranking number, and the next item(s) receive the immediately
# following ranking number.
# For more information, please refer to wiki page.
# https://en.wikipedia.org/wiki/Ranking

use warnings;
use strict;
use feature qw/ say /;
use Test::More tests => 3;

my @sorted_values = ( 1, 2, 2, 2, 3, 5, 5, 6, 6, 7, 7, 8, 8, 8, 8, 9, 9, 10 );
my @test_values = ( 2, 4, 4, 7 );

ok( get_standard(@test_values) eq "1 2 2 4", "standard ranking" );
ok( get_modified(@test_values) eq "1 3 3 4", "modified ranking" );
ok( get_dense(@test_values) eq "1 2 2 3",    "dense ranking" );

say
    "\nRank the values @sorted_values\nenter\t's' (Standard Ranking)\n\t'm' (Modified Ranking)\n\t'd' (Dense Ranking)";

chomp( my $answer = <> );

if ( $answer eq 's' ) {
    say "Standard Ranking: " . get_standard(@sorted_values);
}
elsif ( $answer eq 'm' ) {
    say "Modified Ranking: " . get_modified(@sorted_values);
}
elsif ( $answer eq 'd' ) {
    say "Dense Ranking: " . get_dense(@sorted_values);
}
else {
    say "You did not enter a valid ranking";
}

# returns Standard Ranking as a string
sub get_standard {
    my @values   = @_;
    my $rankings = "";
    my $position = 0;
    my $rank     = 1;
    foreach (@values) {
        if ( $position == 0 || $_ == $values[ $position - 1 ] ) {
            $position++;
        }
        else {
            $position++;
            $rank = $position;
        }
        $rankings = $rankings . ( $rank . " " );
    }
    $rankings =~ s/\s+$//;
    return $rankings;
}

# returns Modified Ranking as a string
sub get_modified {
    my @values   = @_;
    my $rankings = "";
    my $position = 0;
    my $count    = 0;
    foreach (@values) {
        # Shorten with 1 long if statment which negates the first 2?
        # $position and $count are incremented in each case.
        # Might be harder to read.
        if ( $position == 0 && $_ == $values[ $position + 1 ] ) {
            $position++;
            $count++;
        }
        elsif ( ( $position + 1 ) < scalar @values
            && $_ == $values[ $position + 1 ] )
        {
            $position++;
            $count++;
        }
        else {
            $position++;
            $count++;
            $rankings .= ( ( $position . " " ) x $count );
            $count = 0;
        }
    }
    $rankings =~ s/\s+$//;
    return $rankings;
}

# returns Dense Ranking as a string
sub get_dense {
    my @values   = @_;
    my $rankings = "";
    my $position = 0;
    my $rank     = 1;
    foreach (@values) {
        if ( $position == 0 || $_ == $values[ $position - 1 ] ) {
            $position++;
        }
        else {
            $position++;
            $rank++;
        }
        $rankings .= ( $rank . " " );
    }
    $rankings =~ s/\s+$//;
    return $rankings;
}

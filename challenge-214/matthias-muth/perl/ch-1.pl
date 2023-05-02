#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 214 Task 1: Rank Score
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;
use feature 'say';

my @medals = qw( G S B );

sub rank_score {
    my @scores = @_;
    my @sorted_scores = sort { $b <=> $a } @scores;
    my %ranks;
    $ranks{$sorted_scores[$_]} //= $medals[$_] // $_ + 1
        for 0..$#sorted_scores;
    return map $ranks{$_}, @scores;
}

use Test::More;
use Data::Dump qw( pp );

do {
    is_deeply [ rank_score( @{$_->{INPUT}} ) ], $_->{EXPECTED},
        "rank_score( " . pp( @{$_->{INPUT}} ) . " ) == " . pp( @{$_->{EXPECTED}} );
} for (
    { INPUT => [ 1,2,4,3,5 ],     EXPECTED => [ qw( 5 4 S B G ) ] },
    { INPUT => [ 8,5,6,7,4 ],     EXPECTED => [ qw( G 4 B S 5 ) ] },
    { INPUT => [ 3,5,4,2 ],       EXPECTED => [ qw( B G S 4 ) ] },
    { INPUT => [ 2,5,2,1,7,5,1 ], EXPECTED => [ qw( 4 S 4 6 G S 6 ) ] },
);

done_testing;

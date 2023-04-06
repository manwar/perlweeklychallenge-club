#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 210 Task 1: Kill and Win
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;

use List::Util qw( sum max );

sub kill_and_win {
    my @list = @_;

    my %numbers;
    @numbers{@list} = @list;
    my @numbers = sort keys %numbers;

    return
        max(
            map {
                my $n = $_;
                sum( grep { $n - 1 <= $_ && $_ <= $n + 1 } @list );
            } @numbers
        );
}

use Test::More;

do {
    is kill_and_win( @{$_->{INPUT}} ), $_->{EXPECTED},
        "kill_and_win(" . join( ",", @{$_->{INPUT}} ) . ") == $_->{EXPECTED}";
} for (
    { INPUT => [ 2,3,1 ], EXPECTED => 6 },
    { INPUT => [ 1,1,2,2,2,3 ], EXPECTED => 11 },
);

done_testing;

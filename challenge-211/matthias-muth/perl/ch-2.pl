#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 210 Task 2: Split Same Average
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;
use feature 'say';

use List::Util qw( sum );

sub find_sum {
    my ( $target_sum, @list ) = @_;
    for ( 0..$#list ) {
        return 1
            if $list[$_] == $target_sum
            || ( $list[$_] < $target_sum
                && find_sum(
                    $target_sum - $list[$_],
                    @list[ $_ + 1 .. $#list ] ) );
    }
    return 0;
}

sub split_same_average {
    my ( @list ) = @_;
    my $sum = sum @list;
    return "false"
        unless $sum % 2 == 0;
    my $target_sum = $sum / 2;
    return find_sum( $target_sum, @list ) ? "true" : "false";
}

use Test::More;

do {
    is find_sum( @{$_->{INPUT}} ), $_->{EXPECTED},
        "find_sum(" . join( ",", @{$_->{INPUT}} )
            . ") == " . $_->{EXPECTED};
} for (
    { INPUT => [ 6, 8,1,7,3,4,2,6,7 ], EXPECTED => 1 },
);

do {
    is_deeply split_same_average( @{$_->{INPUT}} ), $_->{EXPECTED},
        "split_same_average(" . join( ",", @{$_->{INPUT}} )
            . ") == " . $_->{EXPECTED};
} for (
    { INPUT => [ 1..8 ], EXPECTED => "true" },
    { INPUT => [ 1,3 ], EXPECTED => "false", },
);

done_testing;

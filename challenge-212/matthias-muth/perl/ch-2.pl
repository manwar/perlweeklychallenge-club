#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 212 Task 2: Rearrange Groups
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;
use feature 'say';

use Data::Dump qw( pp );
use List::Util qw( min );

sub rearrange_groups {
    my ( $list, $size ) = @_;
    my %available;

    return -1
        if @$list % $size != 0;

    $available{$_}++
        for @$list;

    my @groups;
    while ( %available ) {
        push @groups, [];
        my $first_element = min( keys %available );
        for ( $first_element .. $first_element + $size - 1 ) {
            return -1
                unless $available{$_};
            push @{$groups[-1]}, $_;
            delete $available{$_}
                if --$available{$_} == 0;
        }
    }
    return \@groups;
}

use Test::More;

do {
    is_deeply rearrange_groups( @{$_->{INPUT}} ), $_->{EXPECTED},
        "rearrange_groups(" . pp( @{$_->{INPUT}} )
            . ") == " . pp( $_->{EXPECTED} );
} for (
    { TEST => "Example 1",
      INPUT => [ [ 1,2,3,5,1,2,7,6,3 ], 3 ],
      EXPECTED => [ [ 1,2,3 ], [ 1,2,3 ], [ 5,6,7 ] ] },
    { TEST => "Example 2",
      INPUT => [ [ 1,2,3 ], 2 ],
      EXPECTED => -1 },
    { TEST => "Example 3",
      INPUT => [ [ 1,2,4,3,5,3 ], 3 ],
      EXPECTED => [ [ 1,2,3 ], [ 3,4,5 ] ] },
    { TEST => "Example 4",
      INPUT => [ [ 1,5,2,6,4,7 ], 3 ],
      EXPECTED => -1 },
);

done_testing;

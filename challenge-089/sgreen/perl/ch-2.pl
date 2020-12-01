#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use List::Util qw(none);

sub _combinations {
    my $a = shift;

    # Return all six ways that three numbers can be ordered
    return (
        [ $a->[0], $a->[1], $a->[2] ],
        [ $a->[0], $a->[2], $a->[1] ],
        [ $a->[1], $a->[0], $a->[2] ],
        [ $a->[1], $a->[2], $a->[0] ],
        [ $a->[2], $a->[0], $a->[1] ],
        [ $a->[2], $a->[1], $a->[0] ],
    );
}

sub main {

    # Work out all ordered combinations of three number that total 15
    my @rows = ();
    for my $a ( 1 .. 4 ) {
        for my $b ( $a + 1 .. 6 ) {
            for my $c ( $b + 1 .. 9 ) {
                push @rows, [ $a, $b, $c ] if $a + $b + $c == 15;
            }
        }
    }

    # Get all possible solutions using the above defined rows
    my @solutions = ();
    for my $first_row (@rows) {
        my %first_seen = ( map { $_, 1 } @$first_row );
        for my $second_row (@rows) {
            if ( none { $first_seen{$_} } @$second_row ) {
                # The third row is numbers not in the first two rows
                my %second_seen = ( map { $_, 1 } @$second_row );
                my $third_row =
                  [ grep { !$first_seen{$_} and !$second_seen{$_} }
                      ( 1 .. 9 ) ];
                push @solutions, [ $first_row, $second_row, $third_row ];
            }
        }
    }

    # We now have all possible solutions, but don't know the order of
    # values in each row. Time for some brute force work
    foreach my $solution (@solutions) {
        foreach my $first_row ( _combinations( $solution->[0] ) ) {
            foreach my $second_row ( _combinations( $solution->[1] ) ) {
                foreach my $third_row ( _combinations( $solution->[2] ) ) {
                    if ( $first_row->[0] + $second_row->[0] + $third_row->[0] == 15
                        and $first_row->[1] + $second_row->[1] + $third_row->[1] == 15
                        and $first_row->[2] + $second_row->[2] + $third_row->[2] == 15
                        and $first_row->[0] + $second_row->[1] + $third_row->[2] == 15
                        and $first_row->[2] + $second_row->[1] + $third_row->[0] == 15 )
                    {
                        # We have the solution
                        foreach ( $first_row, $second_row, $third_row ) {
                            say '[ ', join( ' ', @$_ ), ' ]';
                        }
                        return;
                    }
                }
            }
        }
    }
}

main();

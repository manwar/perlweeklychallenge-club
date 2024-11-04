#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub similar_dominoes($dominoes) {
    my $count = 0;
  OUTER: foreach my $i ( 0 .. $#$dominoes ) {
        foreach my $j ( 0 .. $#$dominoes ) {
            if ( $i == $j ) {
                # Don't compare the same domino!
                next;
            }
            if (
                (
                        $dominoes->[$i][0] == $dominoes->[$j][0]
                    and $dominoes->[$i][1] == $dominoes->[$j][1]
                )
                or (    $dominoes->[$i][0] == $dominoes->[$j][1]
                    and $dominoes->[$i][1] == $dominoes->[$j][0] )
              )
            {
                # There is a match
                $count++;
                next OUTER;
            }
        }
    }

    # Return the number of matching dominoes
    return $count;
}

sub main (@ints) {
    my @dominoes = ();
    for ( my $i = 0 ; $i <= $#ints ; $i += 2 ) {
        push @dominoes, [ $ints[$i], $ints[ $i + 1 ] ];
    }
    my $result = similar_dominoes( \@dominoes );
    say $result;
}

main(@ARGV);

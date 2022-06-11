#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub strip {
    my $s = shift;
    $s =~ s/^\s*//;
    $s =~ s/\s*$//;
    return $s;
}

sub main {
    # Split the input on pipes
    my $s         = shift;
    my @rows      = split( /\|/, $s );
    my $min_depth = 1;

  ROW: foreach my $row ( @rows[ 1 .. $#rows ] ) {
        # Split the row, and expand if missing values
        my @v = split( /\s+/, strip($row) );
        while ( @v < 2**$min_depth ) {
            push @v, '*';
        }

        # Go through each pair, and exit if we find two '*'
        for ( my $i = 0 ; $i < $#v ; $i += 2 ) {
            if ( $v[$i] eq '*' and $v[ $i + 1 ] eq '*' ) {
                last ROW;
            }
        }
        $min_depth++;
    }

    say $min_depth;
}

main(@ARGV);
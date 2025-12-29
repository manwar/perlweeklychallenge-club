#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'none';

sub main (@inputs) {
    # Take the input from the command line
    my ( @codes, @names, @status );
    for ( my $i = 0 ; $i < @inputs ; $i += 3 ) {
        push @codes,  $inputs[$i];
        push @names,  $inputs[ $i + 1 ];
        push @status, $inputs[ $i + 2 ];
    }

    my @output      = ();
    my @valid_names = ( "electronics", "grocery", "pharmacy", "restaurant" );

    foreach my $i ( 0 .. $#codes ) {
        my $is_valid = 'true';
        if ( $codes[$i] !~ /^[A-Za-z0-9_]+$/ ) {
            $is_valid = 'false';
        }
        elsif ( none { $names[$i] eq $_ } @valid_names ) {
            $is_valid = 'false';
        }
        elsif ( lc( $status[$i] ) eq "false" ) {
            # The status is a string of 'true' or 'false', not boolean type.
            $is_valid = 'false';
        }
        elsif ( lc( $status[$i] ne 'true' ) ) {
            die "Status must be 'true' or 'false', not '$status[$i]'\n";
        }
        push @output, $is_valid;
    }

    say "(" . join( ", ", @output ) . ")";
}

main(@ARGV);

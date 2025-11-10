#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub is_balanced ($s) {
    my $count = 0;
    foreach my $char ( split //, $s ) {
        if ( $char eq '(' ) {
            $count++;
        }
        elsif ( $char eq ')' ) {
            $count--;
            return 0 if $count < 0;
        }
    }
    return $count == 0;
}

sub main ($input_string) {
    # Check the input string is only parentheses
    if ( $input_string !~ /^[()]+$/ ) {
        die "Input string must contain only parentheses '()'\n";
    }

    for ( my $len = length($input_string) ; $len > 1 ; $len-- ) {
        foreach my $start ( 0 .. length($input_string) - $len ) {
            my $substring = substr( $input_string, $start, $len );
            if ( is_balanced($substring) ) {
                say $len;
                return;
            }
        }
    }

    say 0;

}

main( $ARGV[0] );

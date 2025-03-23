#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ( $name, $typed ) {
    my $r = '^' . join( '+', map { quotemeta } split //, $name ) . '+$';
    say $typed =~ $r ? 'true' : 'false';
}

main( $ARGV[0], $ARGV[1] );
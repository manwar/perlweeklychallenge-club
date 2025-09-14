#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use JSON 'decode_json';
use List::Util qw(max sum);

sub main ($matrix) {
    my $max = max( map { sum @$_ } @$matrix );
    say $max;
}

main( decode_json( $ARGV[0] ) );

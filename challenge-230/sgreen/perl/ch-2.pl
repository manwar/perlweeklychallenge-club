#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ( $prefix, @words ) {
    my $len      = length($prefix);
    my @solution = grep { substr( lc $_, 0, $len ) eq lc($prefix) } @words;
    say scalar(@solution);
}

# The last input is the prefix
my $prefix = pop(@ARGV);
main( $prefix, @ARGV );
#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 220 Task 1: Common Characters
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;
use feature 'say';

use lib '.';
use TestExtractor;

use List::Util qw( reduce any );
use Data::Dump qw( pp );

sub common_characters {
    my ( @words ) = map lc( $_ ), @_;
    my @results = split "", $words[0];
    for my $word ( @words[1..$#words] ) {
        @results = grep $word =~ /$_/, @results;
    }
    return sort @results;
}

run_tests;

1;

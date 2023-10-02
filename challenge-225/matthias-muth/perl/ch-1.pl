#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 225 Task 1: Max Words
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;
use feature 'say';

use lib '.';
use TestExtractor;

use List::Util qw( max );

sub max_words {
    my ( @list ) = @_;
    return max( map { scalar split " ", $_ } @list );
}

run_tests;

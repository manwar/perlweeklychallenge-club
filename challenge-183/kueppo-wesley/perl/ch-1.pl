#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw(smartmatch);
use feature      qw(say);

use Test::More;

my @uniq;
my @list = ( [ 9, 1 ], [ 3, 7 ], [ 2, 5 ], [ 2, 5 ] );

# Man..... you gotta use `for(|each)'!!! :)
map { my $aref = $_; push @uniq, $aref unless grep { @$aref ~~ @$_ } @uniq } @list;

is_deeply( [@uniq], [ [ 9, 1 ], [ 3, 7, ], [ 2, 5 ] ] );

done_testing( 1 );

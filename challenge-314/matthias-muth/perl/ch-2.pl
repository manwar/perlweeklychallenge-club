#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 314 Task 2: Sort Column
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use List::Util qw( zip any );

sub sort_column( @list ) {
    my @columns = zip map [ split "", $_ ], @list;
    return scalar grep {
	my $column = $_;
	any { $column->[$_] le $column->[ $_ - 1 ] } 1..$column->$#*;
    } @columns;
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is sort_column( "swpc", "tyad", "azbe" ), 2,
    'Example 1: sort_column( "swpc", "tyad", "azbe" ) == 2';
is sort_column( "cba", "daf", "ghi" ), 1,
    'Example 2: sort_column( "cba", "daf", "ghi" ) == 1';
is sort_column( "a", "b", "c" ), 0,
    'Example 3: sort_column( "a", "b", "c" ) == 0';

done_testing;

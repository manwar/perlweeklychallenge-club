#!/usr/bin/perl

use strict;
use feature 'say';

## This solves more than the puzzle - but thought I would make it more generic!

## This gets the size of the square that we want to display...

my $N  = shift =~ s{\D}{}gr || 11;        ## Default to 11 - but use first parameter as size of square!
my @R  = 1..$N;                           ## Create a "range array" - we use this 4 times!!!

## Get width of columns for use in the renderer..

my $sl = int( log($N) / log(10) + 1);     ## Get size of integer $N - defines the width of the LH column
my $sr = int( 2 * log($N) / log(10) + 1); ## Get size of $N squared - defines the width of other columns
my $fl = sprintf ' %%%dd |', $sl;         ## Create a template for the first column..
my $fr = sprintf ' %%%dd', $sr;           ## .... and for the other columns!

## Finally we render - make a use of sprintf with the templates and '$' x $ to generate padding

say ' ' x $sl, 'x |',                                               ## Header (LH side)
    map          { sprintf $fr, $_ }                            @R; ##        (column headers)
say join '-', '-' x $sl, '-+',                                      ## Separator (LH side)
    map          { '-' x $sr }                                  @R; ##           (RH side)
say sprintf( $fl, $a=$_ ),                                          ## Body of table (LH headers)
    map          { $a>$_ ? ' ' x ($sr+1) : sprintf $fr, $a*$_ } @R  ##               (content of row)
    foreach                                                     @R;


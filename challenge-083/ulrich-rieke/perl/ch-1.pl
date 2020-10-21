#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

my $S = $ARGV[ 0 ] ;
my @words = split /\s+/ , $S ;
my $innerlength = 0 ;
map { $innerlength += length $_ } @words[1 .. $#words - 1] ;
say $innerlength ;

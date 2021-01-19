#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

my $S = $ARGV[ 0 ] ;
$S =~ s/^\s*?// ;
$S =~ s/s+$// ;
my @words = split( /\s+/ , $S ) ;
say join( ' ', reverse @words ) ;

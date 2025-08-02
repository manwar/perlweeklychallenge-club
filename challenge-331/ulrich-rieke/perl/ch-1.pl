#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a string!" ;
my $word = <STDIN> ;
chomp $word ;
$word =~ s/^\s+// ;
$word =~ s/\s+$// ;
my @words = split( /\s+/ , $word ) ;
say length( $words[-1] ) ;

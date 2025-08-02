#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s+/ , $line ) ;
say "Enter a target integer!" ;
my $k = <STDIN> ;
chomp $k ;
my $len = scalar( @numbers ) ;
my @sorted = sort { $a <=> $b } @numbers ;
my @indices = grep { $sorted[ $_ ] == $k } (0..$len - 1) ;
print "(" ;
print join( ',' , @indices ) ;
say ")" ;

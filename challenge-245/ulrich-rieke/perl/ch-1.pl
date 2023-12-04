#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some programming languages, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @languages = split( /\s/ , $line ) ;
say "Enter some popularity indices, separated by blanks!" ;
$line = <STDIN> ;
chomp $line ;
my @popularity = split( /\s/ , $line ) ;
my @pairs ;
for my $i ( 0..scalar( @languages) - 1 ) {
   push @pairs , [$popularity[ $i ] , $languages[ $i ]] ;
}
my @sorted = sort { $a->[0] <=> $b->[0] } @pairs ;
print "(" ;
say join( ',' , map { $_->[1] } @sorted ) . ")" 

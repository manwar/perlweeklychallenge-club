#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @firstNumbers = split( /\s/ , $line ) ;
say "Enter some more integers, separated by blanks!" ;
$line = <STDIN> ;
chomp $line ;
my @secondNumbers = split( /\s/ , $line ) ;
my %firstHash ;
my %secondHash ;
map { $firstHash{$_}++ } @firstNumbers ;
map { $secondHash{$_}++ } @secondNumbers ;
my @firstDiff = grep { not ( exists ( $secondHash{$_} ) ) } keys %firstHash ;
my @secondDiff = grep { not ( exists ( $firstHash{$_} ) ) } keys %secondHash ;
print "((" ;
if ( @firstDiff ) {
   print join( ',' , @firstDiff ) ;
}
if ( @secondDiff ) {
   say ") , (" . join( ',' , @secondDiff ) . "))" ;
}
else {
   say "))" ;
}

#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all zip ) ;

say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @firstNumbers = split( /\s+/ , $line ) ;
say "Enter the same number of integers, separated by blanks!" ;
$line = <STDIN> ;
chomp $line ;
my @secondNumbers = split( /\s+/ , $line ) ;
my @firstSorted = sort { $a <=> $b } @firstNumbers ;
my @secondSorted = sort { $a <=> $b } @secondNumbers ;
my @zipped = zip \@firstSorted , \@secondSorted ;
my $comp = $zipped[0]->[1] - $zipped[0]->[0] ;
if ( all { $_->[1] - $_->[0] == $comp } @zipped ) {
   say $comp ;
}
else {
   say " " ;
}

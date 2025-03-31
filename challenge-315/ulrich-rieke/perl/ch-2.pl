#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a sentence!" ;
my $sentence = <STDIN> ;
chomp $sentence ;
say "Enter a first word!" ;
my $first = <STDIN> ;
chomp $first ;
say "Enter a second word!" ;
my $second = <STDIN> ;
chomp $second ;
my @solution ;
#the regex assumes that the first word always comes before the second!
while ( $sentence =~ /$second\s+(\w+?)\b/g ) {
   push @solution , $1 ;
}
say '(' . join( ',' , @solution ) . ')' ;

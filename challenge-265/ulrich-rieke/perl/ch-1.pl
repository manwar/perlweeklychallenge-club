#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split ( /\s+/ , $line ) ;
my $len = scalar( @numbers ) ;
my %numhash ;
map { $numhash{$_}++ } @numbers ;
my @selected ;
for my $number ( keys %numhash ) {
   if ( scalar ( grep { $_ == $number } @numbers ) >= $len / 3 ) {
      push( @selected, $number ) ;
   }
}
if ( @selected ) {
   my @sorted = sort { $a <=> $b } @selected ;
   say $sorted[ 0 ] ;
}
else {
   say "undef" ;
}

#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some positive integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s+/ , $line ) ;
my $len = scalar( @numbers ) - 1 ;
#assume result to be true unless proven to be false
my $result = "true" ;
for my $index (0..$len ) {
   if ( scalar( grep { $_ == $index } @numbers ) != $numbers[ $index ] ) {
      $result = "false" ;
   }
}
say $result ;

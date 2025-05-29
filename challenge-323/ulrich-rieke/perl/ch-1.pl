#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some operations separated by blanks!" ;
my $operations = <STDIN> ;
chomp $operations ;
my @ops = split( /\s/ , $operations ) ;
my $value = 0 ;
for my $op ( @ops ) {
   if ( $op =~ /\+{2}/ ) {
      $value++ ;
   }
   if ( $op =~ /\-{2}/ ) {
      $value-- ;
   }
}
say $value ;

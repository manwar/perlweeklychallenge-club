#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub count {
   my $array = shift ;
   my $element = shift ;
   return scalar( grep { $_ == $element } @$array ) ;
}

say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my %frequencies ;
for my $num ( @numbers ) {
   unless ( exists($frequencies{ $num }) ) {
      $frequencies{ $num } = count( \@numbers , $num ) ;
   }
}
my @sorted = sort { $frequencies{ $a } <=> $frequencies{ $b } || 
   $b <=> $a } @numbers ;
say "(" . join( ',' , @sorted ) . ")" ;   

#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( combinations ) ;

say "Enter some positive integers, separated by spaces!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my %frequencies ;
for my $n ( @numbers ) {
   $frequencies{ $n }++ ;
}
for my $n ( keys %frequencies ) {
   $frequencies{ $n } = scalar (grep { $_  == $n } @numbers ) ;
}
my $sum = 0 ;
my @uniques = keys %frequencies ;
if ( scalar( @uniques ) >= 3 ) {
   my $iter = combinations( \@uniques , 3 ) ;
   while ( my $c = $iter->next ) {
      my $product = 1 ;
      for my $d (0..2) {
	 $product *= $frequencies{ $c->[$d] } ;
      }
      $sum += $product ;
   }
   say $sum ;
}
else {
   say 0 ;
}


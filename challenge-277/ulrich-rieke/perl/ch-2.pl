#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( combinations ) ;
use List::Util qw ( min ) ;

say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s+/ , $line ) ;
my %valid_pairs ;
my $iter = combinations( \@numbers , 2 ) ;
while ( my $c = $iter->next ) {
   my $diff = abs( $c->[0] - $c->[1] ) ;
   my $mini = min( @$c ) ;
   if ( (0 < $diff) && ($diff < $mini) ) {
#create a string out of the $c-contents so that not the address enters the
#hash but the values!
      $valid_pairs{$c->[0] . ',' . $c->[1]}++ ;
   }
}
say scalar ( keys %valid_pairs ) ;

#!/usr/bin/perl ;
use strict ;
use warnings ; 
use feature 'say' ;
use List::Util qw ( all ) ;

say "Enter some integers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s+/ , $line ) ;
my %frequencies ;
my @pairs ;
map { $frequencies{$_}++ } @numbers ;
for my $k ( keys %frequencies ) {
   push( @pairs , [$k , $frequencies{$k} ] ) ;
}
my $result = 0 ;
if ( scalar( @pairs ) == 1 ) {
   if ( $pairs[0]->[1] > 1 ) {
      $result = 1 ;
   }
}
else {
   my @sorted = sort { $a->[1] <=> $b->[1] } @pairs ;
   my $mini = $sorted[0]->[1] ;
   if ( $mini > 1 && all { $_->[1] % $mini == 0 } @sorted[1..$#sorted] ) {
      $result = 1 ;
   }
}
if ( $result == 0 ) {
   say "false" ;
}
else {
   say "true" ;
}

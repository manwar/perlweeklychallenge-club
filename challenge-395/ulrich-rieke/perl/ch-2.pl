#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw( permutations combinations) ;

sub condition {
   my $array = shift ;
   my @recombined ;
   my $len = length($array->[0]) ;
   for my $i ( 0..$len - 1 ) {
      my $combined ;
      for my $word( @$array ) {
         $combined .= substr( $word , $i , 1 ) ;
      }
      push( @recombined , $combined ) ;
   }
   for my $i ( 0..$len - 1) {
      if ( $array->[$i] ne $recombined[$i] ) {
         return 0 ;
      }
   }
   return 1 ;
}

say "Enter some words with equal lengths!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s/ , $line ) ;
my $l = length( $words[0] ) ;
my $iter = combinations( \@words , $l ) ;
my @solution ;
while ( my $c = $iter->next( )) {
   my @combi = @$c ;
   my $next_iter = permutations( \@combi ) ;
   while ( my $pc = $next_iter->next( )) {
      if ( condition( $pc ) ) {
         push( @solution , $pc ) ;
      }
   }
}
print "(" ;
for my $elt( @solution ) {
   print '(' . join( ',' , @$elt ) . ')' ;
}
say ')' ;

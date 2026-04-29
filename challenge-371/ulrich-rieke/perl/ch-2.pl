#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( combinations ) ;

sub criterion {
   my $tupel = shift ;
   my $indexsum = 0 ;
   my $numbersum = 0 ;
   my $len = scalar( @$tupel ) ;
   for my $i( 0..$len - 1 ) {
      $indexsum += $tupel->[$i]->[0] ;
      $numbersum += $tupel->[$i]->[1] ;
   }
   if ( $indexsum == $numbersum ) {
      return 1 ;
   }
   else {
      return 0 ;
   }
}

say "Enter some integers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $len = scalar( @numbers ) ;
my @pairs ;
for my $num (1..$len) {
   push( @pairs , [$num , $numbers[$num - 1]]) ;
}
my @solution ;
for my $num( 2..$len - 1 ) {
   my $iter = combinations( \@pairs , $num ) ;
   while ( my $c = $iter->next ) {
      if ( criterion( $c ) ) {
         my @nums = map { $_->[1] } @$c ;
         push( @solution , '(' . join( ',' , @nums ) . ") " ) ;
      }
   }
}
say '(' . join( ',' , @solution ) . ')' ;

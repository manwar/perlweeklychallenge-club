#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( permutations ) ;

sub count {
   my $word = shift ;
   my $letter = shift ;
   return scalar( grep { $_ eq $letter } split( // , $word )) ;
}

sub condition {
   my $word = shift ;
   for my $p (1..length( $word ) - 1) {
      if ( count( substr( $word , 0 , $p ) , 'D' ) > count( substr( $word , 0 , 
                  $p ) , 'U' ) ) {
         return 0 ;
      }
   }
   return 1 ;
}

say "Enter a positive integer!" ;
my $number = <STDIN> ;
chomp $number ;
if ( $number == 0 ) {
   say '""' ;
}
else {
   my %found ;
   my $currentWord ;
   for (0..$number - 1 ) {
      $currentWord .= "U" ;
      $currentWord .= "D" ;
   }
   my @letters ;
   map { push( @letters , $_ ) } split( // , $currentWord ) ;
   my $permuword ;
   my @permus ;
   my $iter = permutations( \@letters ) ;
   while ( my $p = $iter->next ) {
      push( @permus , $p ) ;
   }
   for my $c ( @permus ) {
      for my $let( @$c ) {
         $permuword .= $let ;
      }
      if ( condition( $permuword ) ) {
         $found{$permuword}++ ;
      }
      $permuword = "" ;
   }
   say '(' . join( ',' , sort keys %found ) . ')' ;
}

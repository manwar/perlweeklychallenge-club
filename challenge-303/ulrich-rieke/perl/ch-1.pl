#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( variations ) ;

sub to_number {
   my $array = shift ;
   my $multBy = 100 ;
   my $sum = 0 ;
   for my $n( @$array ) {
      $sum += $n * $multBy ;
      $multBy /= 10 ;
   }
   return $sum ;
}

say "Enter at least 3 one-digit positive integers separated by whitespace!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $iter = variations( \@numbers , 3 ) ;
my @sums ;
while ( my $c = $iter->next ) {
   if ( $c->[0] != 0 ) {
      my $sum = to_number( $c ) ;
      if ( $sum % 2 == 0 ) {
	 push( @sums , $sum ) ;
      }
   }
}
my %uniques ;
map { $uniques{$_}++ } @sums ;
say '(' . join( ',' , sort { $a <=> $b }  keys %uniques )  . ')' ;

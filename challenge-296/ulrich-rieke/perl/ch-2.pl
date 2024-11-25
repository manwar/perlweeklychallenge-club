#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( partitions ) ;
use List::Util qw ( all max sum ) ;

say "Enter some positive integers separated by whitespace!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $len = scalar( @numbers ) ;
if ( $len < 4 ) {
   say "false" ;
}
elsif ( $len == 4 ) {
   if ( all { $_ == $numbers[0] } @numbers ) {
      say "true" ;
   }
   else {
      say "false" ;
   }
}
else {
   if ( sum( @numbers ) % 4 != 0 ) {
      say "false" ;
   }
   else {
      my @sorted = sort { $a <=> $b } @numbers ;
      my $maxi = $sorted[-1] ;
      my %frequencies ;
      map { $frequencies{$_}++ } @sorted ;
      my $maxsum = (4 - $frequencies{$maxi}) * $maxi ;
      say $maxsum ;
      my $restsum = 0 ;
      for my $num ( grep { $_ != $maxi } keys %frequencies ) {
	 $restsum += $frequencies{ $num } ;
      }
      say "restsum : $restsum" ;
      if ( $restsum == $maxsum ) {
	 say "true" ;
      }
      else {
	 say "false" ;
      }
   }
}

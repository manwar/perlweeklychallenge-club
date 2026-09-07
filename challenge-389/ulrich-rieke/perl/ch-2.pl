#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all max ) ;

sub isUndulating {
   my $array = shift ;
   if ( scalar( @$array ) == 1 ) {
      return 1 ;
   }
   if ( scalar( @$array ) == 2 ) {
      if ( $array->[0] != $array->[1] ) {
         return 1 ;
      }
      else {
         return 0 ;
      }
   }
   if ( scalar( @$array ) > 2 ) {
      my @differences ;
      my $len = scalar( @$array ) ;
      for my $i (1..$len - 1 ) {
         push( @differences , $array->[$i] - $array->[$i - 1] ) ;
      }
      if ( all { ($differences[$_] > 0 && $differences[$_ + 1] < 0) || 
            ($differences[$_] < 0 && $differences[$_ + 1] > 0 ) } 
            (0..scalar( @differences) - 2 ) ) {
         return 1 ;
      }
      else {
         return 0 ;
      }
   }
}

say "Enter some numbers separated by whitespace!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my @sizes ;
my $len = scalar( @numbers ) ;
my @subarrays ;
for my $start( 0..$len - 2) {
   for my $end( $start + 1 .. $len - 1) {
      push( @subarrays , [@numbers[$start..$end]] ) ;
   }
}
for my $s( @subarrays ) {
   if ( all { $_ == $s->[0] } @$s ) {
      push( @sizes , 1 ) ;
   }
   if ( isUndulating( $s ) ) {
      push( @sizes , scalar( @$s ) ) ;
   }
}
say max @sizes ;

#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub isAscending {
   my $array = shift ;
   my $len = scalar( @$array ) ;
   for my $i (0..$len - 2 ) {
      if ( $array->[$i + 1] - $array->[$i] != 1 ) {
	 return 0 ;
      }
   }
   return 1 ;
}

say "Enter a word!" ;
my $word = <STDIN> ;
chomp $word ;
my %wordpos ;
for my $pos ( 0..length( $word ) - 1 ) {
   push( @{$wordpos{substr( $word , $pos , 1 ) }} , $pos ) ;
}
my @solution ;
my %found ;
for my $pos( 0..length( $word ) - 1 ) {
   my @positions ;
   map { push( @positions, $_ ) } @{$wordpos{substr( $word , $pos , 1 )}} ;
   if ( scalar( @positions ) >= 3 && isAscending(\@positions)) {
      my $string = substr( $word , $pos , 1 ) x (scalar( @positions ) ) ;
      if ( not exists( $found{$string} )) {
	 push( @solution , $string ) ;
	 $found{$string}++ ;
      }
   }
}
if ( @solution ) {
   say join( ',' , @solution ) ;
}
else {
   say "\"\"" ;
}

#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub find {
   my $array = shift ;
   my $elt = shift ;
   my $pos = 0 ;
   while ( $array->[$pos] != $elt ) {
      $pos++ ;
   }
   return $pos ;
}

say "Enter a list of integers!" ;
my $line = <STDIN> ;
chomp $line ;
my @firstnums = split( /\s+/ , $line ) ;
say "Enter a list of the same integers as above!" ;
$line = <STDIN> ;
chomp $line ;
my @secondnums = split( /\s+/ , $line ) ;
if ( scalar( @firstnums ) == 1 && scalar( @secondnums ) == 1 ) {
   say "true" ;
}
else {
   my @sumpositions ;
   for my $pos (0..scalar( @firstnums) - 1 ) {
      push( @sumpositions , [$pos , $pos +
	    find( \@secondnums, $firstnums[$pos] )] ) ;
   }
   my %sums ;
   for my $elt ( @sumpositions ) {
      push( @{$sums{$elt->[1]}} , $elt->[0] ) ;
   }
   my @selected = grep { scalar( @$_ ) > 1 && isAscending( $_ ) } values 
      %sums ;
   if ( scalar( @selected ) == 1 ) {
      say "true" ;
   }
   else {
      say "false" ;
   }
}

sub isAscending {
   my $array = shift ;
   my $len = scalar( @$array ) ;
   for my $pos (0..$len - 2 ) {
      if ( $array->[$pos + 1] - $array->[$pos] != 1 ) {
	 return 0 ;
      }
   }
   return 1 ;
}

#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( sum ) ;

sub digitsum {
   my $number = shift ;
   return sum( split( // , $number ) ) ;
}

#create pieces of a given length , corresponding to rotor in Raku
sub divide {
   my $number = shift ;
   my $chunksize = shift ;
   my @parts ;
   my $len = length $number ;
   my $pos = 0 ;
   while ( $pos < $len ) {
      push( @parts , substr( $number , $pos , $chunksize ) ) ;
      $pos += $chunksize ;
   }
   my $letters_used_so_far = scalar( @parts ) * $chunksize ;
#add the unconsumed rest of $number to @parts!
   if ( $letters_used_so_far < $len ) {
      push( @parts , substr( $number , $letters_used_so_far ) ) ;
   }
   return @parts ;
}

say "Enter a string consisting of numbers only!" ;
my $numberstring = <STDIN> ;
chomp $numberstring ;
say "Enter a number less than the length of the number string!" ;
my $chunksize = <STDIN> ;
chomp $chunksize ;
my @parts = divide( $numberstring , $chunksize ) ;
my $sumstring ; #string formed by the digit sums of @parts
map { $sumstring .= digitsum( $_ ) } @parts ;
while ( length( $sumstring ) > $chunksize ) {
   @parts = divide( $sumstring , $chunksize ) ;
   $sumstring = "" ;
   map { $sumstring .= digitsum( $_ ) } @parts ;
}
say $sumstring ;


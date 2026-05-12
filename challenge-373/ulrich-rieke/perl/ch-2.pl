#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use POSIX ; # for floor
use List::MoreUtils qw ( natatime ) ; # chunks an array into n pieces a time

sub printSubarrays { #print a part of the number array
   my $l = shift ; #length of the subarrays
   my $array = shift ; #part of the array where we want chunks
   my @result ;
   my $it = natatime $l , @$array ;
   while ( my @vals = $it->( ) ) {
      if ( scalar( @vals ) > 1 ) {
         push( @result , '(' . join( ',' , @vals ) . ')' ) ;
      }
      else {
         push( @result , '(' . $vals[0] . ')' ) ;
      }
   }
   return @result ;
}

say "Enter some integers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
say "Enter a positive number!" ;
my $num = <STDIN> ;
chomp $num ;
my $len = scalar( @numbers ) ;
my $total = floor( int( $len / $num )) ;
my $remainder = $len - $num * $total ;
if ( $total == 0 ) {
   say -1 ;
}
else {
   my @solution ;
   if ( $remainder != 0 ) {
      my @subarray ;
      for my $el( @numbers[0..$remainder * ( $total + 1) - 1] ) {
         push( @subarray , $el ) ;
      }
      my @result = printSubarrays( $total + 1 , \@subarray ) ;
      @subarray = ( ) ;
      map { push( @solution , $_ ) } @result ;
      for my $el( @numbers[$remainder * ($total + 1)..($len - 1)] ) {
         push( @subarray , $el ) ;
      }
      @result = printSubarrays( $total , \@subarray ) ;
      map { push( @solution , $_ ) } @result ;
   }
   else {
      my @result = printSubarrays( $total , \@numbers ) ;
      map { push( @solution , $_ ) } @result ;
   }
   say '(' . join( ',' , @solution ) . ')' ;
}

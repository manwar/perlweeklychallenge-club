#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( sum ) ;
use POSIX ;

sub digitSum {
   my $number = shift ;
   my @digits ;
   while ( $number != 0 ) {
      push( @digits , $number % 10 ) ;
      $number = floor( $number / 10 ) ;
   }
   return sum @digits ;
}

sub convert {
   my $word = shift ;
   my $numberword ;
   for my $letter( split( // , $word ) ) {
      $numberword .= ord( $letter ) - 96 ;
   }
   return $numberword ;
}

say "Enter a word consisting of lowercase English letters only!" ;
my $word = <STDIN> ;
chomp $word ;
say "Enter a positive integer!" ;
my $k = <STDIN> ;
chomp $k ;
my $result = digitSum( convert( $word ) ) ;
$k-- ;
while ( $k != 0 ) {
   $result = digitSum( $result ) ;
   $k-- ;
}
say $result ;





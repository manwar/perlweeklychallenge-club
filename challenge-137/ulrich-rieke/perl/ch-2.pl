#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub isPalindrome {
  my $num = shift ;
  return $num eq (join ('', reverse split( // , $num ))) ;
}

my $n = $ARGV[ 0 ] ;
while ( $n < 10 || $n > 1000 ) {
  say "number should be between 5 and 1000!" ;
  $n = <STDIN> ;
  chomp $n ;
}
my $iterations = 0 ;
my $number = $n ;
my $output = 1 ;
while ( $iterations < 500 ) {
  $number += (join ('' , reverse split( // , $number )) + 0 ) ;
  if ( isPalindrome ( $number ) ) {
      $output = 0 ;
      last ;
  }
  if ( $number > 10000000 ) {
      last ;
  }
  $iterations++ ;
}
if ( $iterations >= 500 ) {
  $output = 1 ;
}
say $output ;

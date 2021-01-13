#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub isPalindrome {
  my $N = shift ;
  return $N eq join( '' , reverse split( // , $N ) ) ;
}

my $N = $ARGV[0] ;
say isPalindrome( $N ) ? 1 : 0 ;

#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all ) ;
use POSIX ;

sub isSpecial {
  my $number = shift ;
  if ( $number < 10 ) {
      return 1 ;
  }
  else {
      my %frequencies ;
      while ( $number != 0 ) {
    $frequencies{ $number % 10 }++ ;
    $number = floor( $number / 10 ) ;
      }
      return all { $_ == 1 } values %frequencies ;
  }
}

my $num = $ARGV[0] ;
my $count = 0 ;
for my $i ( 1 .. $num ) {
  if ( isSpecial( $i ) ) {
      $count++ ;
  }
}
say $count ;

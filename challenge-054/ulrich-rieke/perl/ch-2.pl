#!/usr/bin/perl ;
use strict ;
use warnings ;

sub findSequence {
  my $n = shift ;
  my @sequence ;
  while ( $n != 1 ) {
      push( @sequence , $n ) ;
      if ( $n % 2 == 0 ) {
    $n /= 2 ;
      }
      else {
    $n = $n * 3 + 1 ;
      }
  }
  push( @sequence , $n ) ;
  return @sequence ;
}

my @sequence = findSequence( $ARGV[ 0 ] ) ;
map { print "$_\n" } @sequence ;
print scalar @sequence . "\n" ;
my @sequences ;
for my $i (1..1000000) {
  @sequence = findSequence( $i ) ;
  push( @sequences , [ $i , scalar @sequence] ) ;
}
my @sorted = sort { ${$b}[1] <=> ${$a}[1]} @sequences ;
print "The 20 longest Collatz sequences in numbers up to 1000000:\n" ;
map { print ${$_}[0] . " " . ${$_}[1] . "\n" } @sorted[0..19] ;


#!/usr/bin/perl ;
use strict ;
use warnings ;

sub findTriplets {
  my $sum = shift ;
  my $array = shift ;
  my $len = scalar @{$array} ;
  my @result ;
  if ( $len < 3 ) {
      return ( ) ;
  }
  foreach my $i ( 0..$len - 2 ) {
      my $a = ${$array}[ $i ] ;
      my $start = $i + 1 ;
      my $end = $len - 1 ;
      while ( $start < $end ) {
    my $b = ${$array}[ $start ] ;
    my $c = ${$array}[ $end ] ;
        if ( $a + $b + $c == $sum ) {
        my @innerresult ;
        push( @innerresult, $a , $b , $c ) ;
        push( @result , \@innerresult ) ;
        $start++ ;
        $end-- ;
    }
    elsif ( $a + $b + $c > $sum ) {
        $end-- ;
    }
    else {
        $start++ ;
    }
      }
  }
  return @result ;
}

my @L = (-25 , -10 , -7 , -3 , 2 , 4 , 8 , 10 ) ;
my @sorted = sort { $a <=> $b } @L ;
my @result = findTriplets( 3 , \@sorted ) ;
if ( @result ) {
  foreach my $subarray ( @result ) {
      print "${$subarray}[0] , ${$subarray}[1] , ${$subarray}[2]\n" ;
  }
}
else {
  print "no fitting result!\n" ;
}

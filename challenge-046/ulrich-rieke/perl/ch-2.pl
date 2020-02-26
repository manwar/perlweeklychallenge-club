#!/usr/bin/perl ;
use strict ;
use warnings ;

sub flip {
  my $state = shift ;
  if ( $state eq "open" ) {
      return "closed" ;
  }
  else {
      return "open" ;
  }
}

my @doors ;
for my $i (1..500) {
  push ( @doors, [ $i , "open" ] ) ;
}
for my $i (2..500) {
  if ( $i < 251 ) {
      for ( my $j = $i ; $j < 500 ; $j += $i ) {
    ${$doors[ $j - 1]}[1] = flip ( ${$doors[ $j - 1 ]}[1]) ;
      }
  }
  else {
      ${$doors[ $i - 1 ]}[1] = flip ( ${$doors[ $i - 1 ]}[1] ) ;
  }
}
for my $d ( 1..500) {
  if ( ${$doors[ $d - 1 ]}[1] eq "open" ) {
      print "door $d is open!\n" ;
  }
}

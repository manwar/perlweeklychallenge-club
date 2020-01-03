#!/usr/bin/perl ;
use strict ;
use warnings ;

my @leonardos = ( 1 , 1 ) ;
while ( (scalar @leonardos ) < 20 ) {
  push @leonardos , $leonardos[-1] + $leonardos[-2] + 1 ;
}
for my $num ( @leonardos ) {
  print "$num " ;
}
print "\n" ;

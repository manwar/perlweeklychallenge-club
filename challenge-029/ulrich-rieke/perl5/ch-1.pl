#!/usr/bin/perl ;
use strict ;
use warnings ;

#works only if there is no whitespace within the expansion bracket!
my $howoften = @ARGV - 2 ;
for my $i (1..$howoften) {
  print "$ARGV[0] $ARGV[ $i ] $ARGV[-1]\n" ;
}

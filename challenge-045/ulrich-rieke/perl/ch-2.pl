#!/usr/bin/perl ;
use strict ;
use warnings ;

open (FH , "< $0" ) or die "Can't open file $0!\n" ;
while ( <FH> ) {
  print ;
}
close (FH) ;

#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

my @cities = ("Berlin", "Amsterdam", "Moscow") ;
my $addr = \@cities ;
say "The address of \@cities is $addr!" ;

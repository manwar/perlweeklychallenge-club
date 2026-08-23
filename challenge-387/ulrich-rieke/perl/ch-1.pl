#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a binary string!" ;
my $binary = <STDIN> ;
chomp $binary ;
my $steps = 0 ;
while ( $binary =~ /01/ ) {
   $binary =~ s/01/10/g ;
   $steps++ ;
}
say $steps ;

#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a string consisting of letters only!" ;
my $s = <STDIN> ;
chomp $s ;
while ( $s !~ /^[a-zA-Z]+$/ ) {
  say "string must consist of letters only! Re-enter!" ;
  $s = <STDIN> ;
  chomp $s ;
}
if ( $s =~ /^[A-Z]+$/ || $s =~ /^[a-z]+$/ || $s =~ /^[A-Z][a-z]+$/) {
  say 1 ;
}
else {
  say 0 ;
}

#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all ) ;

say "Enter a string of 1 and 0 only!" ;
my $line = <STDIN> ;
chomp $line ;
my $len = length $line ;
my @subblocks ;
my $i = 0 ;
while ( $i < $len - 2 ) {
  push @subblocks, substr( $line , $i , 2 ) ;
  $i += 2 ;
}
push @subblocks , substr( $line , $i , $len - $i ) ;
if ( all { $_ =~ /^[01]+$/ } @subblocks ) {
  my $last_element = $subblocks[ -1 ] ;
  if ( $last_element eq "0" || $last_element eq "00" ) {
      say 1 ;
  }
  else {
      say 0 ;
  }
}
else {
  say 0 ;
}

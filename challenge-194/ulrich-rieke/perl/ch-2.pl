#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( max min ) ;

my $input = $ARGV[ 0 ] ;
my %letterfrequencies ;
for my $letter ( split( //, $input )) {
  $letterfrequencies{ $letter }++ ;
}
my $maximum = max( values %letterfrequencies ) ;
my $minimum = min( values %letterfrequencies ) ;
my @selected = grep { $letterfrequencies{$_} == $minimum } keys
%letterfrequencies ;
if ( $maximum == $minimum + 1 && scalar( @selected ) == ( scalar( keys
        %letterfrequencies ) - 1 )) {
  say 1 ;
}
else {
  say 0 ;
}

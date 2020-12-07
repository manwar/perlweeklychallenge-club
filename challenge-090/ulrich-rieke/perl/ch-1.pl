#!/usr/bin/perl ;
use strict ;
use warnings ;

my $sequence = $ARGV[ 0 ] ;
my %pairings = ( 'A' => 'T' , 'C' => 'G' , 'G' => 'C' , 'T' => 'A' ) ;
my %basefrequencies ;
my $complementary ;
for my $i ( 0 .. length $sequence ) {
  my $let = substr( $sequence , $i , 1 ) ;
  $basefrequencies{$let}++ ;
  $complementary .= $pairings{ $let } ;
}
print "The base frequencies are:\n" ;
print "A: $basefrequencies{ 'A'}\n"  ;
print "C: $basefrequencies{ 'C' }\n" ;
print "T: $basefrequencies{ 'T' }\n";
print "G: $basefrequencies{ 'G' }\n" ;
print "The complementary sequence is:\n" ;
print $complementary . "\n" ;

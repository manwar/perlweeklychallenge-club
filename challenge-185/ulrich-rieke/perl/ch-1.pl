#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a MAC address in the form hhhh.hhhh.hhhh!" ;
my $address = <STDIN> ;
chomp $address ;
while ( $address !~ /\A(\w{4}\.){2}\w{4}\z/ ) {
  say "The MAC address should have the form hhhh.hhhh.hhhh!" ;
  $address = <STDIN> ;
  chomp $address ;
}
my @parts = split( /\./ , $address ) ;
my @chunks ;
for my $part( @parts ) {
  push @chunks , substr( $part , 0 , 2 ) ;
  push @chunks, substr( $part , 2 , 2 ) ;
}
say join( ':' , @chunks ) ;

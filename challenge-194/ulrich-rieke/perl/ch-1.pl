#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a time in the form hh:mm, with one position replaced by a '?'!" ;
my $time = <STDIN> ;
chomp $time ;
my $pos = index( $time , '?' ) ;
my $digit = 10 ;
while ( $time !~ /^(0[0-9] |1[0-9]|2[0-3]):[0-5][0-9]$/ ) {
  $digit-- ;
  if ( $time !~ /\?/ ) {
      substr( $time, $pos , 1 ) = '?' ;
  }
  $time =~ s/\?/$digit/ ;
}
say $digit ;

#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a string with lowercase English letters and digits only!" ;
my $word = <STDIN> ;
chomp $word ;
my %found ;
while ( $word =~ /(\d+)/cg ) {
   $found{$1} = index( $word , $1 ) ;
}
my @sorted = sort { $found{$a} <=> $found{$b} } keys %found ;
say join( ',' , @sorted ) ;

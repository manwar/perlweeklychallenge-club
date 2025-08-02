#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( min ) ;

say "Enter some integers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @firstnumbers = split( /\s+/ , $line ) ;
say "Enter some more integers separated by blanks!" ;
$line = <STDIN> ;
chomp $line ;
my @secondnumbers = split( /\s+/ , $line ) ;
my %firstSet ;
my %secondSet ;
map { $firstSet{$_}++ } @firstnumbers ;
map { $secondSet{$_}++ } @secondnumbers ;
my @common = grep { exists( $secondSet{ $_ } ) } keys %firstSet ;
if ( @common ) {
   say min( @common ) ;
}
else {
   say -1 ;
}


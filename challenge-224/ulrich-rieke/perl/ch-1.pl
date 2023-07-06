#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all ) ;

say "Enter a source string!" ;
my $source = <STDIN> ;
chomp $source ;
say "Enter a target string!" ;
my $target = <STDIN> ;
chomp $target ;
my %sourceHash ;
my %targetHash ;
map { $sourceHash{$_}++ } split ( // , $source ) ;
map { $targetHash{$_}++ } split ( // , $target ) ;
if ( all { (exists( $sourceHash{$_} )) && ( $sourceHash{$_} >=
    $targetHash{$_} ) } keys %targetHash ) {
  say "true" ;
}
else {
  say "false" ;
}

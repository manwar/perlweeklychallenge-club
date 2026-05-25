#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some strings separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @firstWords = split( /\s/ , $line ) ;
say "Enter some more strings separated by blanks!" ;
$line = <STDIN> ;
chomp $line ;
my @secondWords = split( /\s/ , $line ) ;
my %firstFrequencies ;
my %secondFrequencies ;
map {$firstFrequencies{$_}++ } @firstWords ;
map { $secondFrequencies{$_}++ } @secondWords ;
say scalar( grep { exists( $secondFrequencies{$_} ) && 
      $firstFrequencies{$_} == 1 && $secondFrequencies{$_} == 1 } 
      keys %firstFrequencies ) ;

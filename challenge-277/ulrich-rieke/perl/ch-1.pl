#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some words, separated by blanks!" ;
my $firstLine = <STDIN> ;
chomp $firstLine ;
my @firstWords = split( /\s+/ , $firstLine ) ;
say "Enter more words , separated by blanks!" ;
my $secondLine = <STDIN> ;
chomp $secondLine ;
my @secondWords = split( /\s+/ , $secondLine ) ;
my %firstFreqs ;
my %secondFreqs ;
map { $firstFreqs{$_}++ } @firstWords ;
map { $secondFreqs{$_}++ } @secondWords ;
my @common = grep {exists( $secondFreqs{$_} ) } keys %firstFreqs ;
say scalar( grep {$firstFreqs{$_} == 1 && $secondFreqs{$_} == 1} @common ) ; 

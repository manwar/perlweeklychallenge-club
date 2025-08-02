#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some numbers several times, only one number once!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s+/ , $line ) ;
my %frequencies ;
map { $frequencies{$_}++ } @numbers ;
my @selected = grep { $frequencies{$_} == 1 } @numbers ;
say $selected[0] ;

#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some words, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
say "Enter a prefix!" ;
my $prefix = <STDIN> ;
chomp $prefix ;
my @words = split( /\s/ , $line ) ;
say scalar( grep { $_ =~ /^$prefix/ } @words ) ;

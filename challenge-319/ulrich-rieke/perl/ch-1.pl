#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some words separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s+/ , $line ) ;
my $vowel = '[aeiouAEIOU]' ;
my @selected = grep { $_ =~ /^$vowel/ || $_ =~ /$vowel$/ } @words ;
say scalar( @selected ) ;

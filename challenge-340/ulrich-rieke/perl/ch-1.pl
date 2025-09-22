#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a word!" ;
my $word = <STDIN> ;
chomp $word ;
while ( $word =~ /((.)\2)/cg ) {
   $word =~ s/$1// ;
}
say $word ;

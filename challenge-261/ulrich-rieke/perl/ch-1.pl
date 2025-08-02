#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( sum ) ;

say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s+/ , $line ) ;
my $element_sum = sum( @numbers) ;
my $digit_sum = sum( map { sum( split( // , $_ )) } @numbers ) ;
say abs( $element_sum - $digit_sum ) ;

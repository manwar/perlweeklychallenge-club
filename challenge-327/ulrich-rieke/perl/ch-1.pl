#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some integers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $len = scalar( @numbers ) ;
my %found ;
map { $found{$_}++ } @numbers ;
my @selected = grep { not exists( $found{$_} ) } (1..$len) ;
say '(' . join( ',' , @selected ) . ')' ;

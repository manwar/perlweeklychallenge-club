#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( sum ) ;

say "Enter some positive integers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $numbersum = sum( @numbers ) ;
my @digits = map { [split(// , $_)] } @numbers ;
my $all_digit_sum = sum( map { sum( @$_ ) } @digits ) ;
say abs( $numbersum - $all_digit_sum ) ;

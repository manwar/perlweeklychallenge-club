#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use POSIX ;
use List::Util qw ( min ) ;

#find the minimum absolute value!
say "Enter some integers separated by whitespace!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my @differences = map { abs( $_) } @numbers ;
say min( @differences ) ;

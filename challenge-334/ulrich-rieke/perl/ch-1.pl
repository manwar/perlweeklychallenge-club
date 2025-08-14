#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( sum ) ;

say "Enter some integers separated by spaces!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s+/ , $line ) ;
say "Enter two valid indices into this array!" ;
$line = <STDIN> ;
chomp $line ;
my @indices = split( /\s+/ , $line ) ;
say sum( @numbers[$indices[0]..$indices[1]] ) ;

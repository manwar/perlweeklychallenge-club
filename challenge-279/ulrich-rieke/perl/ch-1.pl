#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( zip ) ;

say "Enter some letters , separated by blanks!" ;
my $letters = <STDIN> ;
chomp $letters ;
my @letters = split( /\s+/ , $letters ) ;
say "Enter some weights , separated by blanks!" ;
my $weights = <STDIN> ;
chomp $weights ;
my @weights = split( /\s+/ , $weights ) ;
my @zipped = zip( \@letters , \@weights ) ;
my @sorted = sort { $a->[1] <=> $b->[1] } @zipped ;
say join( '' , map { $_->[0] } @sorted ) ;

#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a date as year-month-day!" ;
my $date = <STDIN> ;
chomp $date ;
my @dateparts = split( /\-/ , $date ) ;
my @transformed = map { sprintf("%b" , $_) } @dateparts ;
say join( '-' , @transformed ) ;

#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some tickets, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split ( /\s/ , $line ) ;
#I assume all ticket data to be in the right format!
say scalar( grep { substr( $_ , 11 , 2 ) >= 60 } @words ) ;

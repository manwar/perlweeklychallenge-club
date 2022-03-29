#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( product sum ) ;

say "Enter a number of integers, separated by a blank!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s+/ , $line ) ;
my $len = scalar( @numbers ) ;
my $am = sum( @numbers ) / $len ;
my $gm = (product( @numbers )) ** (1 / $len ) ;
my $hm = $len / ( sum ( map { 1 / $_ } @numbers ) ) ;
my @formatted = map { sprintf( "%.1f" , $_) } ( $am , $gm , $hm ) ;
say "AM = $formatted[0] , GM = $formatted[1] , HM = $formatted[2]" ;

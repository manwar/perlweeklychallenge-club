#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( max ) ;

say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s+/ , $line ) ;
my %frequencies ;
map { $frequencies{$_}++ } @numbers ;
my @selected = grep { $frequencies{$_} == $_ } @numbers ;
my $len = scalar( @selected ) ;
if ( $len > 1 ) {
   say max( @selected ) ;
}
elsif ( $len == 1 ) {
   say $selected[0] ;
}
else {
   say -1 ;
}



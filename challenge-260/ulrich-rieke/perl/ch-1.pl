#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my %uniques ;
my %frequencies ;
my @numbers = split( /\s+/ , $line ) ;
for my $num ( @numbers ) {
   $uniques{ $num }++ ;
}
for my $num ( keys %uniques ) {
   $frequencies{ scalar( grep { $_ eq $num } @numbers ) }++ ;
}
if ( scalar( keys %frequencies ) == scalar( keys %uniques ) ) {
   say 1 ;
}
else {
   say 0 ;
}

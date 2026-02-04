#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a word consisting of alphabetic characters only!" ;
my $word = <STDIN> ;
chomp $word ;
while ( $word =~ /(.)\1/ ) {
   $word =~ s/(.)\1// ;
}
if ( length $word == 0 ) {
   say "\"\"" ;
}
else {
   say $word ;
}

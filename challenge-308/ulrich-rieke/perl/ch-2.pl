#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some integers separated by whitespace!" ;
my $line = <STDIN> ;
chomp $line ;
my @encoded = split( /\s/ , $line ) ;
say "Enter an integer!" ;
my $num = <STDIN> ;
chomp $num ;
#we can use xor as its own inverse function so to find x in a xor x = b 
#we can do a xor b!
my @decoded = ($num) ;
for my $number ( @encoded ) {
   my $last = $decoded[-1] ;
#by adding zero I enforce numberlike behaviour ; simply applying ^ as 
#operator doesn't produce results reliably!!!
   push(@decoded , ($last + 0) ^ ($number + 0))   ;
}
say '(' . join( ',' , @decoded ) . ')' ;

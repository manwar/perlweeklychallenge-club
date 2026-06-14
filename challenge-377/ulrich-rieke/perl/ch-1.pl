#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( any ) ;

say "Enter a word!" ;
my $word = <STDIN> ;
chomp $word ;
my %forward_pairs ;
my $len = length( $word ) ;
for my $i (0..$len - 2 ) {
   $forward_pairs{substr( $word , $i , 2 )}++ ;
}
my $backword = join( '' , reverse split( // , $word )) ;
my %backward_pairs ;
for my $i (0..$len - 2 ) {
   $backward_pairs{substr( $backword, $i , 2 )}++ ;
}
if ( any { exists( $backward_pairs{$_} ) } keys %forward_pairs ) {
   say "true" ;
}
else {
   say "false" ;
}

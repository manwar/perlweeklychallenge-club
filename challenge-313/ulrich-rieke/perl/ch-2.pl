#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a string!" ;
my $word = <STDIN> ;
chomp $word ;
my @letters = split(// , $word) ;
my $reversed ;
my @alpha_letters ;
for my $c ( @letters ) {
   if ( $c =~ /[a-zA-Z]/ ) {
      push( @alpha_letters , $c ) ;
   }
}
my @reversed_alpha = reverse @alpha_letters ;
for my $c ( @letters ) {
   if ( $c !~ /[a-zA-Z]/ ) {
      $reversed .= $c ;
   }
   else {
      my $first = shift( @reversed_alpha ) ;
      $reversed .= $first ;
   }
}
say $reversed ;

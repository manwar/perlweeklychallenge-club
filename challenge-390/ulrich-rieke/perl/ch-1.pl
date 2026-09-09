#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub rewrite_inner {
   my $multiplier = shift ;
   my $innerterm = shift ;
   return $innerterm x $multiplier ;
}

say "Enter an encoded string!" ;
my $term = <STDIN> ;
chomp $term ;
while ( $term =~ /(\d+)\[([a-z])\]/ ) {
   $term =~ s/(\d+)\[([a-z])\]/rewrite_inner( $1 , $2 )/eg ;
}
while ( $term =~ /(\d+)\[([a-z]{2,})\]/ ) {
   $term =~ s/(\d+)\[([a-z]{2,})\]/rewrite_inner( $1 , $2 )/eg ;
}
say $term ;

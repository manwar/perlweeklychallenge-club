#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub rearrange {
   my $binary = shift ;
   my $len = length( $binary ) ;
   my $ones = scalar( grep { $_ eq '1' } split( // , $binary )) ;
   return '1' x ( $ones - 1 ) . ( '0' x ( $len - $ones )) . '1' ;
}

say "Enter a binary term with at least one 1!" ;
my $binary = <STDIN> ;
chomp $binary ;
say rearrange( $binary ) ;

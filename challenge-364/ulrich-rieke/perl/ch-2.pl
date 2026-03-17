#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub solution {
   my $word = shift ;
   $word =~ s/\(\)/o/g ;
   $word =~ s/\(al\)/al/g ;
   return $word ;
}

say solution( "G()(al)" ) ;
say solution( "G()()()()(al)" ) ;      
say solution( "(al)G(al)()()" ) ;
say solution( "()G()G" ) ;
say solution( "(al)(al)G()()" ) ;


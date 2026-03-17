#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub solution {
   my $word = shift ;
   my $conversions = shift ;
   while ( $word =~ /\d{2}#/ ) {
      $word =~ s/(\d{2}#)/$conversions->{$1}/ ;
   }
   while ( $word =~ /\d/ ) {
      $word =~ s/(\d)/$conversions->{$1}/ ;
   }
   return $word ;
}

my $lowerletters = "abcdefghi" ;
my $upperletters = "jklmnopqrstuvwxyz" ;
my %conversions ;
for my $i (0..length $lowerletters) {
   $conversions{$i + 1} = substr( $lowerletters , $i , 1 ) ;
}
for my $i (0..length $upperletters) {
   $conversions{(10 + $i) . '#'} = substr( $upperletters , $i , 1 ) ;
}
say solution( "10#11#12" , \%conversions ) ;
say solution( "1326#" , \%conversions) ;
say solution( "25#24#123", \%conversions ) ;
say solution( "20#5" , \%conversions ) ;
say solution( "1910#26#" , \%conversions ) ;

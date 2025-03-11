#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub hashify {
   my $array = shift ;
   my %h ;
   map { $h{$_}++ } @$array ;
   return %h ;
}

say "Enter a string with R, G or B as colors and subsequent numbers!" ;
my $input = <STDIN> ;
chomp $input ;
my %boxes ;
my $len = length( $input ) ;
my $pos = 0 ;
while ( $pos < $len - 1 ) {
   my $box = substr( $input , $pos + 1 , 1 ) ;
   my $color = substr( $input , $pos , 1 ) ;
   push( @{$boxes{$box}} , $color ) ;
   $pos += 2 ;
}
my $total = 0 ;
for my $b( keys %boxes ) {
   my @letters = @{$boxes{ $b }} ;
   my %set = hashify( \@letters ) ;
   if ( scalar( keys %set ) == 3 ) {
      $total++ ;
   }
}
say $total ;

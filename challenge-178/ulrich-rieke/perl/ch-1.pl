#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Math::Complex ;
use List::Util qw ( reduce ) ;

sub from_quater_imaginary {
  my $numberstring = shift ;
  my $quaterHash = shift ;
  my $sum = Math::Complex->make( 0 , 0 ) ;
  my $reversed = reverse substr( $numberstring, 0 , (length $numberstring) - 2 ) ;
  my $len = length $reversed ;
  for my $position (0 .. $len - 1 ) {
      my $firstFactor = Math::Complex->make( substr( $reversed, $position , 1 ) , 0 ) ;
      $sum = $sum + $firstFactor * $quaterHash->{ $position } ;
  }
  return $sum ;
}

sub into_quater_imaginary {
  my $number = shift ;
  my $quaterHash = shift ;
  my @real_only_products ;
  for my $num( 0 .. 4 ) {
      push @real_only_products , $quaterHash->{2 * $num} ;
  }
  my @solutions ;
  for my $e ( 0 .. 3 ) {
      for my $f ( 0 .. 3 ) {
    for my $g ( 0 .. 3 ) {
        for my $h ( 0 .. 3 ) {
          for my $i ( 0 .. 3 ) {
          if (($real_only_products[0] * $e + $real_only_products[1] * $f +
            $real_only_products[2] * $g + $real_only_products[3] * $h +
            $real_only_products[4] * $i) == $number) {
            my $solution = reduce { $a . $b } ( $e , 0 , $f , 0 ,  $g , 0 ,
              $h , 0 , $i ) ;
            $solution = (reverse $solution) . " 2i" ;
            push @solutions , $solution ;
          }
          }
        }
    }
      }
  }
  return @solutions ;
}

sub trimLeadingZeroes {
  my $term = shift ;
  $term =~ s/\A(0+)([0-3]+\s2i)\z/$2/ ;
  return $term ;
}

my %powers_of_imaginary ;
my $base = Math::Complex->make( 0 , 2 ) ;
$powers_of_imaginary{0} = Math::Complex->make( 1 , 0 ) ;
$powers_of_imaginary{1} = $base ;
my @imaginaries = ( $base , $base ) ;
for my $num ( 2 .. 10 ) {
  $powers_of_imaginary{ $num } = reduce { $a * $b } @imaginaries ;
  push @imaginaries , $base  ;
}
say "Please enter a number string! If it is quater-imaginary, end with 2i !" ;
my $numberstring = <STDIN> ;
chomp $numberstring ;
if ( $numberstring =~ /2i/ ) {
  my $complex = from_quater_imaginary( $numberstring , \%powers_of_imaginary ) ;
  say $complex ;
}
else {
  my @solutions = into_quater_imaginary( $numberstring , \%powers_of_imaginary ) ;
  my @withoutLeadingZeroes = map { trimLeadingZeroes( $_ ) } @solutions ;
  map { say $_ } @withoutLeadingZeroes ;
}

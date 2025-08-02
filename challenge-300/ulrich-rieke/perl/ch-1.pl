#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( permutations ) ;

sub condition {
   my $permu = shift ;
   for my $i (1..scalar( @$permu ) ) {
      if ( not ( $permu->[$i - 1] % $i == 0 || $i % $permu->[$i - 1] == 0 ) ) {
	 return 0 ;
      }
   }
   return 1 ;
}

say "Enter a positive integer!" ;
my $number = <STDIN> ;
chomp $number ;
my @numbers ;
for my $i (1..$number ) {
   push @numbers , $i ;
}
my $iter = permutations( \@numbers ) ;
my $sum = 0 ;
while ( my $permu = $iter->next ) {
   if ( condition( $permu ) ) {
      $sum++ ;
   }
}
say $sum ;

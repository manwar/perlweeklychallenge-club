#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( combinations ) ;

#the Hamming distance is equivalent to the difference in ones between
#the orred and the anded combination of the 2 numbers
sub distance {
   my $firstNum = shift ;
   my $secondNum = shift ;
   $firstNum += 0 ; #enforce numberlike behaviour
   $secondNum += 0 ;#same here
   my $orred = $firstNum | $secondNum ;#otherwise, it will produce
#nonsense right here !
   my $anded = $firstNum & $secondNum ; #same here....
   my $orstring = sprintf( "%b" , $orred ) ;
   my $andstring = sprintf( "%b" , $anded ) ;
   my $orones = scalar( grep { $_ eq '1' } split( // , $orstring ) ) ;
   my $andones = scalar( grep { $_ eq '1' } split( // , $andstring ) ) ;
   return ( $orones - $andones ) ;
}

say "Enter some integers separated by whitespace!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $iter = combinations( \@numbers , 2 ) ;
my $sum = 0 ;
while ( my $c = $iter->next ) {
   $sum += distance( $c->[0] , $c->[1] ) ;
}
say $sum ;

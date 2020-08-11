#!/usr/bin/perl ;
use strict ;
use warnings ;

sub decode {
  my $array = shift ;
  my $len = length ${$array}[0] ;
  my $decoded ;
  for my $i (0..$len - 1 ) {
      my %letterfrequency ;
      foreach my $word ( @{$array} ) {
    $letterfrequency{ substr( $word , $i , 1 ) }++ ;
      }
      my @sorted = sort { $letterfrequency{$b} <=>
    $letterfrequency{$a} } keys %letterfrequency ;
      $decoded .= $sorted[0] ;
  }
  return $decoded ;
}

my @strings = ("Hx14!" , "ce-lo" , "ze6lg" , "HWlvR" , "q9m#o" ) ;
print (decode ( \@strings ) . "\n" ) ;
@strings = @strings = ("P+2l!ato" , "1e80R\$4u" , "5-r]+a>/" , "Pxwlb3k\\" ,
      "2e35R8yu" , "<!r^()k0" ) ;
print (decode ( \@strings ) . "\n" ) ;

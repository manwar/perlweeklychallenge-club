#!/usr/bin/perl ;
use strict ;
use warnings ;

sub printListItems {
  my $minlength = @{$_[0]} + 0 ;
  foreach my $list ( @_ ) {
      my $len = @{$list} + 0 ;
      if ( $len < $minlength ) {
    $minlength = $len ;
      }
  }
  print "$minlength \n" ;
  my $i = 0 ;
  while ( $i < $minlength ) {
      foreach my $list ( @_ ) {
    print "${$list}[$i] " ;
      }
      print "\n" ;
      $i++ ;
  }
}

my @array1 = ( 'I', 'L' , 'O' , 'V', 'E' , 'Y', 'O' , 'U' ) ;
my @array2 = (2 , 4, 0, 3 , 2,  0 , 1, 9 ) ;
my @array3 = ('!',  '?' ,  '£' , '$' , '%' , '^', '&' , '*' ) ;
printListItems( \@array1 , \@array2 , \@array3 ) ;

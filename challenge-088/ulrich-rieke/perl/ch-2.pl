#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature "state" ;

sub enterArray {
  my ( $rows , $cols ) = @_ ;
  my @array ;
  print "Please enter $rows rows of $cols numbers each!\n" ;
  for (0 .. $rows - 1 ) {
      my @subarray ;
      my $number ;
      my $count = 0 ;
      while ( $count < $cols ) {
    $number = <STDIN> ;
    chomp $number ;
    while ( $number !~ /\d+/ ) {
        print "please enter a number!\n" ;
        $number = <STDIN> ;
        chomp $number ;
    }
    push @subarray , $number ;
    $count++ ;
      }
      print "You just entered:\n" ;
      map { print "$_ " } @subarray ;
      print "\n" ;
      push @array , \@subarray ;
  }
  return @array ;
}

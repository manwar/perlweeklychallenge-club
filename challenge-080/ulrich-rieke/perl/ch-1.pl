#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub enterArray {
  my @array ;
  say "Enter number ( 'e' to end )!" ;
  my $line = <STDIN> ;
  chomp $line ;
  while ( $line ne 'e' ) {
      if ( $line =~ /\b[-]*\d+\b/ ) {
    push( @array , $line ) ;
      }
      say "Next number :" ;
      $line = <STDIN> ;
      chomp $line ;
  }
  return @array ;
}

my @array = enterArray( ) ;
my @positives = grep { $_ > 0 } @array ;
my %numhash ;
for my $num ( @positives ) {
  $numhash{$num}++ ;
}
my $current = 1 ;
while ( exists $numhash{ $current } ) {
  $current++ ;
}
say $current ;

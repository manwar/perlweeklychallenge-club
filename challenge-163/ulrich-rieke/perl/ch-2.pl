#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( sum ) ;

sub createOutputList {
  my $input = shift ;
  my $len = scalar( @{$input} ) ;
  my @output ;
  for my $current( 1 .. $len - 1 ) {
      push @output , sum( @{$input}[1 .. $current] ) ;
  }
  return @output ;
}

say "Enter a list of numbers, separated by a blank!" ;
my $row = <STDIN> ;
chomp $row ;
while ( $row !~ /\s*(\d+\s)+/ ) {
  say "Please enter numbers only, separated by spaces!" ;
  $row = <STDIN> ;
  chomp $row ;
}
my @numbers = split( /\s/ , $row ) ;
my @output = @numbers ;
while ( scalar( @output ) != 1 ) {
  @output = createOutputList( \@output ) ;
}
say $output[0] ;

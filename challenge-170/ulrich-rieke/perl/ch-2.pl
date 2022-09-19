#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( max ) ;

sub createRow {
  my $firstLine = shift ;
  my $secondLine = shift ;
  my @result ;
  for my $n1 ( split( /\s+/ , $firstLine )) {
      for my $n2 ( split( /\s+/ , $secondLine )) {
    push @result , $n1 * $n2 ;
      }
  }
  return join( ' ' , @result ) ;
}

sub createBlockFromLine {
  my $line = shift ;
  my $block = shift ;
  my @result ;
  for my $row( @$block ) {
      push @result , createRow( $line , $row ) ;
  }
  return @result ;
}

sub kronecker {
  my $firstMatrix = shift ;
  my $secondMatrix = shift ;
  my @result ;
  for my $row( @$firstMatrix ) {
      push @result , createBlockFromLine( $row , $secondMatrix ) ;
  }
  return @result ;
}

sub printMatrix {
  my $matrix = shift ;
  my @allNumbers ;
  for my $row( @$matrix ) {
      for my $num( split( /\s/ , $row )) {
    push @allNumbers , $num ;
      }
  }
  my $maxLen = length ( max( @allNumbers ) . "" ) + 1 ;
  for my $row( @$matrix ) {
      print '[' ;
      for my $num( split( /\s/ , $row )) {
    print (' ' x ( $maxLen - ( length ($num . "" ))) . $num . ' ') ;
      }
      say ']' ;
  }
}

sub enterMatrix {
  say "Please enter a natural numbers separated by spaces!" ;
  say "Enter end to stop matrix entry!" ;
  my @matrix ;
  my $line = <STDIN> ;
  chomp $line ;
  my $numberCount = scalar( split( /\s+/ , $line ) ) ;
  while ( $line ne "end" ) {
      my $nextNumberCount = scalar( split( /\s+/ , $line )) ;
      if ( $nextNumberCount == $numberCount ) {
    push @matrix , $line ;
      }
      else {
    say "You should enter as many numbers as in the first line of the matrix!" ;
    say "Re-enter!" ;
      }
      $line = <STDIN> ;
      chomp $line ;
  }
  return @matrix ;
}

my @firstMatrix = enterMatrix( ) ;
my @secondMatrix = enterMatrix( ) ;
my @kron_product = kronecker( \@firstMatrix , \@secondMatrix ) ;
printMatrix (\@kron_product ) ;

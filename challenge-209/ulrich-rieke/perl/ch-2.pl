#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( any ) ;

sub merge {
  my $firstArray = shift ;
  my $secondArray = shift ;
  my %elementCount ;
  for my $el ( @$firstArray ) {
      $elementCount{$el}++ ;
  }
  for my $el ( @$secondArray ) {
      $elementCount{$el}++ ;
  }
  if ( any { $_ > 1 } values %elementCount ) {
      return sort keys %elementCount ;
  }
  else {
      return ( ) ;
  }
}

say "Enter some email addresses , separated by blanks, end to end!" ;
my $line = <STDIN> ;
chomp $line ;
my %accountHash ; #all email addresses with a common starting letter
while ( $line ne "end" ) {
  my @input = split( /\s/ , $line ) ;
  my $letter = $input[ 0 ] ;
  my @addresses = @input[1..$#input] ;
  push @{$accountHash{ $letter } } , \@addresses ;
  $line = <STDIN> ;
  chomp $line ;
}
my @output ;
for my $l ( sort keys %accountHash ) {
  my $outline = [$l] ;
  my @addresslists = @{$accountHash{$l}} ;#how many lists of addresses have we got ?
  my $len = scalar( @addresslists ) ;
  if ( $len > 1 ) {#we compare the address lists pairwise
#we introduce a hash that indicates whether a list of addresses could be paired.
#if yes it is put to 1 and keeps that value, otherwise it is 0
      my %foundPartner ;
      for my $i (0..$len - 1 ) {
    $foundPartner{ $i } = 0 ;
      }
      for my $i ( 0..$len - 2 ) {
    for my $j ( ($i + 1)..$len - 1 ) {
        my @merged = merge( $addresslists[ $i ] , $addresslists[ $j ] ) ;
        if ( @merged ) {
          $foundPartner{ $i } = 1 ;
          $foundPartner{ $j } = 1 ;
          for my $el ( @merged ) {
          push @$outline , $el ;
          }
          push @output , $outline ;
        }
    }
      }
      for my $i( 0 .. $len - 1 ) {
    if ( $foundPartner{ $i } == 0 ) {
        for my $el ( @{$addresslists[ $i ] } ) {
          push @$outline , $el ;
        }
        push @output , $outline ;
        $outline = [$l] ;
    }
      }
  }
  else {
      for my $el ( @{$addresslists[0]} ) {
    push @$outline , $el ;
      }
      push @output , $outline ;
  }
}
print "[" ;
for my $elem ( @output ) {
  print "[" ;
  print join( ',' , @$elem ) ;
  print "]" ;
}
print "]\n" ;

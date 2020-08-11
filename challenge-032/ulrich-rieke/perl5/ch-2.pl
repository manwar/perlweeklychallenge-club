#!/usr/bin/perl ;
use strict ;
use warnings ;

sub enterData {
  my %data ;
  my $label = " ";
  my $quantity = 0 ;
  my $multiply = "false" ;
  do {
      print "Label ( end to stop data entry ) ?\n" ;
      $label = <STDIN> ;
      chomp $label ;
  } while ( $label !~ /[a-z]+/ ) ;
  while ( $label ne "end" ) {
    do {
        print "Quantity ?\n" ;
        $quantity = <STDIN> ;
        chomp $quantity ;
    } while ( $quantity !~ /[+-]*\d+|\d+\.\d/ ) ;
    $data{$label} = $quantity ;
    if ( int( $quantity ) != $quantity ) { #it's not an integer
        $multiply = "true" ;
    }
      do {
    print "Label ( end to stop data entry ) ?\n" ;
    $label = <STDIN> ;
    chomp $label ;
      } while ( $label !~ /[a-z]+/ ) ;
  }
  if ( $multiply eq "true" ) {#we have floating point values!
    while ( my ( $key , $value ) = each %data ) {
      $data{ $key } = 10 * $value ;
    }
    }
    return %data ;
}

sub generate_bar_graph {
  my $dats = shift ;
  my %data = %{ $dats } ;
  print "order by values? (y)es or (n)o ?\n" ;
  my $answer = <STDIN> ;
  my @ordered ;
  if ( substr( $answer , 0 , 1 ) eq "y" ) {
      @ordered = sort { $data{ $b } <=> $data{ $a } } keys %data ;
  }
  else {
      @ordered = sort { length( $b ) <=> length( $a ) } keys %data ;
  }
#no more than 40 character should be printed, so we should normalize the
#values of the hash
  my $maximum = 0 ;
  for my $val ( values %data ) {
      if ( $val > $maximum ) {
    $maximum = $val ;
      }
  }
  my $scalefactor ;
  if ( $maximum > 40 ) {
      $scalefactor = 40 / $maximum ;
  }
  if ( $scalefactor ) {
      while ( my ( $key , $val ) = each %data ) {
    $data{ $key } = int ( $scalefactor * $val ) ;
      }
  }
  my $maxlen = 0 ;
  for my $item ( @ordered ) {
      if ( length( $item ) > $maxlen ) {
    $maxlen = length( $item ) ;
      }
  }
  for my $item ( @ordered ) {
      print "$item" ;
      print " " x ( $maxlen - length( $item ) ) ;
      print "|" ;
      print "#" x $data{ $item } . "\n" ;
  }
}

my %data = enterData( ) ;
generate_bar_graph( \%data ) ;


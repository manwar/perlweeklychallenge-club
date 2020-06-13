#!/usr/bin/perl ;
use strict ;
use warnings ;
use Algorithm::Combinatorics qw ( variations_with_repetition ) ;

sub enterArray {
  my $columns = shift ;
  my $rows = shift ;
  my $rowcount = 0 ;
  my @array ;
  while ( $rowcount != $rows ) {
      print "Enter $columns integers, separated by space!\n" ;
      my $input = <STDIN> ;
      chomp $input ;
      while ( scalar ( split ( /\s+/ , $input ) ) != $columns ) {
    print "Not enough columns entered! Please repeat entry!\n" ;
    $input = <STDIN> ;
    chomp $input ;
      }
      my @line = split ( /\s+/ , $input ) ;
      push ( @array , \@line ) ;
      $rowcount++ ;
  }
  return @array ;
}

#we have to create different paths through the number array.
#we can do that by defining rightways shifts for every different row.
#to arrive at the right lower point, the rightward shifts in every row
#have to add up to the number of columns.
#I numbered the columns from 0 to columns - 1.
#by creating "variations with repetitions" with as many elements as rows
#and selecting those that add up to the number of columns I get
#combinations of shifts per row that lead to the right lower corner
sub createPaths {
  my $columns = shift ;
  my $rows = shift ;
  my @onerow = (0..$columns - 1) ;
  my @possibleCombis ;
  my $iter = variations_with_repetition( \@onerow, $rows ) ;
  while ( my $p = $iter->next ) {
      if ( sumUpArray( $p ) == $columns - 1 ) {
    push( @possibleCombis, $p ) ;
      }
  }
  return @possibleCombis ;
}

sub sumUpArray {
  my $array = shift ;
  my $sum = 0 ;
  for my $i ( @{$array} ) {
      $sum += $i ;
  }
  return $sum ;
}

#the number array and the list of shift combinations per row are taken
#in as parameters. We then go through the array and pick up numbers on
#the way
sub findPath {
  my $numbers = shift ;
  my $path = shift ;
  my @nums ;
  my @array = @{$numbers} ;
  my $currentcolumn = 0 ;
  my $currentrow = 0 ;
  while ( @{$path} ) {
      my $howmany = shift @{$path} ;
      if ( $howmany > 0 ) {
    push( @nums , @{$array[ $currentrow ] }[ $currentcolumn..
    $currentcolumn + $howmany]) ;
    $currentcolumn += $howmany ;
      }
      else {
    push( @nums , ${$array[ $currentrow ]}[$currentcolumn] ) ;
      }
      $currentrow++ ;
  }
  return @nums ;
}

print "How many columns ?\n" ;
my $columns = <STDIN> ;
chomp $columns ;
print "How many rows ?\n" ;
my $rows = <STDIN> ;
chomp $rows ;
my @numbers = enterArray( $columns , $rows ) ;
my @combis = createPaths( $columns, $rows ) ;
my $minsum = 1000000 ;
my @minpath ;
foreach my $c ( @combis ) {
  my @nums = findPath( \@numbers , $c ) ;
  my $sum = sumUpArray( \@nums ) ;
  if ( $sum < $minsum ) {
      $minsum = $sum ;
      @minpath = @nums ;
  }
}
print "$minsum(" ;
print join ( '->' , @minpath ) ;
print ")\n" ;

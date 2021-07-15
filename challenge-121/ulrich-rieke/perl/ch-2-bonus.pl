#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( first ) ;

#create a row of random numbers with a given number and a given upper
#limit
sub createRandomRow {
  srand( time ^ $$ ) ; #from the "Camel Book"
  my $howmany = shift ;
  my $upperLimit = shift ;
  my @array ;
  for (1 .. $howmany ) {
      push @array , int( rand $upperLimit ) + 1 ;
  }
  return @array ;
}

#find a number in a row , it can occur multiple times since we randomly
#create these numbers. Therefore, we return an array
sub findColumns {
  my $array = shift ;
  my $number = shift ;
  my @row = @$array ;
  my @columns ;
  for my $col( 0 .. 19 ) {
      if ( $row[ $col ] == $number ) {
    push @columns, $col ;
      }
  }
  return @columns ;
}

#find the next city to visit ; it's the column with the smallest number
#next to 0 provided the city wasn't visited yet
sub findNextCity {
  my $array = shift ; #line from the matrix
  my $placesSeen = shift ; #hash of places visited
  my @row = @$array ;
  my %visited = %{$placesSeen} ;
  my @sorted = sort { $a <=> $b } @row ;#sort by distance
  my $column ;
  my @allColumns ; #for the columns in @row where we find the smallest numbers
#we look at all numbers of the @sorted array except the first one which
#always is 0 , the distance to the city we are in
  for my $i (1 .. 19 ) {
      my @columns = findColumns( \@row , $sorted[ $i ] ) ;
      push @allColumns, @columns ;
  }
  $column = first { not exists $visited{ $_ } } @allColumns ;
  return $column ;
}

my @matrix ;
my $row = 0 ;
while ( scalar( @matrix ) < 20 ) {
  my @newEntry ;
#we must reproduce the entries from the rows above
#the difference from city nr. 1 to city nr. 5 in $matrix[1][5] must
#be the same as from city nr. 5 to city nr. 1
  if ( $row > 0 ) {
      for my $column ( 0 .. $row - 1 ) {
    $newEntry[ $column ] = $matrix[ $column ][ $row ] ;
      }
  }
  push @newEntry, 0 ;
  my @randomNumbers = createRandomRow( 20 - $row - 1 , 50 ) ;
  push @newEntry, @randomNumbers ;
  push @matrix,  \@newEntry ;
  $row++ ;
}
my @tour ;
my $len = scalar @matrix ;
my $length = 0 ;
my %visited ;
my $startPlace = 0 ;
my $currentPlace = $startPlace ;
$visited{ $startPlace }++ ;
push @tour , 0 ;
while ( scalar ( keys %visited ) < $len ) {
  my @currentRow = @{$matrix[ $currentPlace ]} ;
  my $column = findNextCity( \@currentRow , \%visited ) ;
  $length += $currentRow[ $column ] ;
  push @tour , $column ;
  $visited{ $column }++ ;
  $currentPlace = $column ;
}
#we must return to the start
push @tour , 0 ;
say "The matrix randomly generated is:" ;
for my $line( @matrix ) {
  say "[" . join( ' ' , @$line ) . "]" ;
}
say "length = $length" ;
say "tour = (" . join( ' ' , @tour ) . ")" ;

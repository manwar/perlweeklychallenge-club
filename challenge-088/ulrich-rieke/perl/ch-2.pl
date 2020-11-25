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

#find the direction of the next move across the array, depending on
#which row and which column we are at and on the information whether
#we were there already. This info is contained in the $visited array
#then, in the main program, we call this function for every field and
#thus determine the next move
sub findDirection {
  my ($visited, $currentRow , $currentCol , $direction ) = @_ ;
  state $maxrows = scalar @$visited ;
  state $maxcols = length $visited->[0] ;
  if ( $direction eq "right" ) {
      if ( $currentCol + 1 < $maxcols and
        substr( $visited->[$currentRow], $currentCol + 1 , 1 ) eq 'n' ) {
    $direction = "right" ;
      }
      else {
    $direction = "down" ;
      }
    }
    if ( $direction eq "down" ) {
    if ( $currentRow + 1 < $maxrows and
          substr( $visited->[$currentRow + 1], $currentCol , 1 ) eq 'n' ) {
        $direction = "down" ;
    }
    else {
        $direction = "left" ;
    }
    }
    if ( $direction eq "left" ) {
    if ( $currentCol - 1 > -1 and
          substr( $visited->[$currentRow], $currentCol - 1 , 1 ) eq 'n' ) {
        $direction = "left" ;
    }
    else {
        $direction = "up" ;
    }
    }
    if ( $direction eq "up" ) {
    if ( $currentRow - 1 > -1  and
          substr( $visited->[$currentRow - 1], $currentCol  , 1 ) eq 'n' ) {
        $direction = "up" ;
    }
    else {
        $direction = "right" ;
    }
    }
    return $direction ;
}

my $m = $ARGV[ 0 ] ;
my $n = $ARGV[ 1 ] ;
my @fields_seen ; #Were we here already ? initiated with 'n' for no
my $unvisitedRow = 'n' x $n ;
for ( 0 .. $m - 1 ) {
  push @fields_seen, $unvisitedRow ;
}
my $curRow = 0 ;
my $curCol = 0 ;
my @array = enterArray( $m , $n ) ;
my @list ; #holds the numbers in spiral order
push @list , $array[ 0 ]->[0] ; #we start at the left upper corner
substr( $fields_seen[ 0 ] , 0 , 1 ) = 'y' ; #and mark this field as seen
my $dir = "right" ;
while ( scalar @list < $m * $n ) {#find the direction and move accordingly
  $dir = findDirection(\@fields_seen, $curRow , $curCol , $dir ) ;
  if ( $dir eq "right" ) {
      $curCol++ ;
  }
  if ( $dir eq "left" ) {
      $curCol-- ;
  }
  if ( $dir eq "up" ) {
      $curRow-- ;
  }
  if ( $dir eq "down" ) {
      $curRow++ ;
  }
  substr( $fields_seen[$curRow] , $curCol , 1 ) = 'y' ;#mark as seen
  push @list , $array[ $curRow ]->[ $curCol ] ;#and add to the spiral list
}
print "[ " ;
map { print "$_ " } split ( // , join (',' , @list ) ) ;
print " ]\n" ;

#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

#check whether a given field is on board
sub isOnBoard {
  my $pos = shift ;
  if ( ($pos->[0] > 0 && $pos->[0] < 9 ) && ( $pos->[1] > 0 and
        $pos->[1] < 9 ) ) {
      return 1 ;
  }
  return 0 ;
}

#start and target positions are given as an array reference
#for every field we create two hashes : %visited which checks whether
#the given field was already visited
#and %pathForField, which stores the path to the given field
sub moveFromFieldToField {
  my $startPos = shift ;
  my $targetPos = shift ;
  my @xmoves = ( -2 , -1 , 1 , 2 , -2 , -1 , 1 , 2 ) ;
  my @ymoves = ( -1 , -2 , -2 , -1 , 1 , 2 , 2 , 1 ) ;
  my @path = ( $startPos ) ; #we begin the path with the start position
  my @allFields = ( $startPos ) ;#we put all valid fields into this array
  my %pathForField ;
  my %visited ;
  for my $i (1 .. 8 ) { #we initiate %visited with 0 ; when visited it's set to 1
      for my $j (1 .. 8 ) {
    $visited{ "$i$j" } = 0 ;
      }
  }
  $pathForField{ join( '' , @$startPos ) } = \@path ;
  my $currentPos ; #for the current position of the knight
  $visited{ join( '' , @$startPos ) } = 1 ; # start position is visited
  while ( @allFields ) { #we shift the fields 1 by 1 from this array to see if we
#are at the target already
      my $topPos = shift @allFields ;
      my @top = @$topPos ; #for the sake of code reliability dereference array refer.
#our new path is the path for the field that we have just shifted from the @allFields
#array
      @path = @{$pathForField{ join( '' , @top ) }} ;
      if ( ($topPos->[0] == $targetPos->[0]) && ( $topPos->[1] #are we there ?
          == $targetPos->[1] ) ) {
#the path for the target position is found in the %pathForField hash
#for heaven's sake, dereference the array reference that is stored as value
#in the hash, with the field being the key. I was in a lot of trouble while I
#didn't do it..
    my @thisPath = @{$pathForField{ join( '' , @$topPos )}} ;
    return @thisPath ;
      }
#starting with the top position from @allFields we do all legal knight moves
      for my $i (0 .. 7 ) {
    $currentPos->[0] = $topPos->[0] ;
    $currentPos->[1] = $topPos->[1] ;
    $currentPos->[0] += $xmoves[ $i ] ;
    $currentPos->[1] += $ymoves[ $i ] ;
    if ( (isOnBoard( $currentPos )) &&
          ($visited{join( '' , @$currentPos)} == 0) ) {
        my @boardarray = @$currentPos ; #dereference!!
        my @newpath = @path ; #dereference the old path
        push @newpath , \@boardarray ;#and add the new legal field on board
        $pathForField{ join( '' , @boardarray) } = \@newpath ;#store it
        push @allFields , \@boardarray ; #store in the fields array
        $visited{ join( '' , @boardarray ) } = 1 ;#and mark as visited
    }
      }
  }
}
my @treasures = ( [6 , 5] , [4 , 3] , [3 , 2 ]  ,
      [2 , 1]  , [2, 2] , [1 , 2]  ) ;
my @path ;#for the way from left upper corner to all treasure fields
my @way = moveFromFieldToField( [8,1] , $treasures[ 0 ] ) ;
push @path , @way ;
my $len = scalar @treasures ;
for my $i (0 .. $len - 2 ) {
  @way = moveFromFieldToField( $treasures[ $i ] , $treasures[ $i + 1 ] ) ;
  push @path , @way[1..$#way] ;#we leave out the index 0 of @way since the starting
#point of move n + 1 was the end point of move n
}
my @iter = map { "(" . join ( ',' , @$_ ) . ")" } @path ;
say join( '->' , @iter ) ;

#!/usr/bin/perl ;
use strict ;
use warnings ;

#are there enough elements in front ?
sub fulfilsCondition {
  my $arraystart = shift ;
  my $element = shift ;
  my $taller_elements = shift ;
  return ( scalar ( grep { $_ > $element } @{$arraystart} )) ==
      $taller_elements ;
}

#check whether an element is in an array
sub inArray {
  my $arraystart = shift ;
  my $number = shift ;
  my $len = scalar @{$arraystart} ;
  foreach my $i (0..$len - 1 ) {
      if ( ${$arraystart}[$i] == $number ) {
    return 1 ;
      }
  }
  return 0 ;
}

my @H = (2, 6, 4, 5, 1, 3) ;
my @T = (1, 0, 2, 0, 1, 2) ;
my %height_to_taller ;
my $len = $#H ;
for my $i ( 0..$len ) {
  $height_to_taller{ $H[ $i ] } = $T[ $i ] ;
}
#check whether reordering of @H is possible at all. It's impossible
#if there have to be more taller elements in front than there are
#taller elements in front in the ordered array
my @sorted = sort { $b <=> $a } @H ;
my @trues ;
for my $i ( 0..$len ) {
  if ( $height_to_taller{ $sorted[ $i ] } <= $i ) {
      push ( @trues , 1 ) ;
  }
  else {
      push ( @trues , 0 ) ;
  }
}
if ( scalar ( grep { $_ == 1 } @trues ) != scalar @H ) {
  print "Error!\n" ;
}
else {
  my @A ;
#create a hash that maps every height to the possible position in the
#reordered array. Every height can assume a position corresponding t0
#the number of taller elements in front + all smaller elements in the
#sorted array
  my %height_to_positions ;
  for my $i ( 0..$len ) {
      my $lowest = $height_to_taller{ $sorted[ $i ]} ;
      my $highest = $lowest + $len - $i ;
      my @positions = ($lowest..$highest ) ;
      $height_to_positions{ $sorted[ $i ] } = \@positions ;
  }
#position for position, check which heights can be there! If only one
#height can go there it has to be picked, otherwise the shortest possible
#position array is selected provided the necessary number of taller elements
#is in front. For the reverse operation ( checking the heights for the
#position ) I stringify the array of possible positions and create another
#hash
  my %positions_to_heights ;
  for my $height ( keys %height_to_positions ) {
      my $positionstr = join ( "" , @{$height_to_positions{ $height }} ) ;
      $positions_to_heights{ $positionstr } = $height ;
  }
  my @all_Positions = values %height_to_positions ;
  for my $i ( 0..$len ) {
      my @ordered_Positions = sort { $#{$a}  <=> $#{$b}  }
    @all_Positions ;
      my @possible_positions = grep { inArray( $_ ,  $i  ) }
        @ordered_Positions ;
    if ( scalar ( @{$possible_positions[ 0 ]} ) == 1 ) {
    $A[ $i ] = $positions_to_heights{ shift @{$possible_positions[ 0 ] }} ;
    delete $height_to_positions{ $A[ $i ] } ;
    delete $height_to_taller{ $A[ $i ] } ;
    }
    else {
    my $pos = 0 ;
    my $string = join ( "" , @{$possible_positions[ $pos ]} ) ;
        my $h = $positions_to_heights{ $string } ;
    my $taller = $height_to_taller{ $h } ;
    while ( not (fulfilsCondition( \@A , $h, $taller ))) {
          $pos++ ;
          $string = join( "" , @{$possible_positions[ $pos ]} ) ;
          $h = $positions_to_heights{ $string } ;
          $taller = $height_to_taller{ $h } ;
        }
    $A[ $i ] = $h ;
    delete $height_to_taller{ $h } ;
    delete $positions_to_heights{ $string } ;
    delete $height_to_positions{ $h } ;
    }
      @all_Positions = values %height_to_positions ;
  }
  print "[ " ;
  map { print "$_ " } @A ;
  print "]\n" ;
}

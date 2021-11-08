use v6 ;

sub computeDistance( @point1 , @point2 --> Num ) {
  return sqrt ( (( @point2[0] - @point1[ 0 ]) ** 2) + (( @point2[1] -
        @point1[1] ) ** 2) ) ;
}

my @points ;
say "Enter the coordinates of four points( blank between x and y! ) ! " ;
for (1 .. 4 ) -> $i {
  say "Enter $i. point:" ;
  my $line = $*IN.get ;
  my @point = $line.split( /\s+/ ) ;
  @points.push( @point ) ;
}
#we know it is a square if the differences of all pairwise neighbours are
#the same and if the diagonals have the same length
my @distances ;
for (1 .. 3 ) -> $i {
  @distances.push( computeDistance( @points[ $i - 1 ] , @points[ $i ] ) ) ;
}
@distances.push( computeDistance( @points[ 3 ] , @points[ 0 ] )) ;
my @diagonals ;
@diagonals.push( computeDistance( @points[ 0 ] , @points[ 2 ] ) ) ;
@diagonals.push( computeDistance( @points[ 1 ] , @points[ 3 ] ) ) ;
if ( @distances.unique.elems == 1 && @diagonals.unique.elems == 1 ) {
  say 1 ;
}
else {
  say 0 ;
}

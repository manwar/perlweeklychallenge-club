use v6 ;

say "Enter the lower left and upper right corner of first rectangle!" ;
say "Separate numbers by spaces!" ;
say "Rectangle 1 =>  " ;
my $line = $*IN.get ;
my @first_numbers = $line.split( /\s/ ).map( {.Int} ) ;
say "Enter the lower left and upper right corner of second rectangle!" ;
say "Separate numbers by spaces!" ;
say "Rectangle 2 =>  " ;
$line = $*IN.get ;
my @second_numbers = $line.split( /\s/ ).map( {.Int} ) ;
#the area covered by the two rectangles is the sum of the areas - the common
#area if there is one. To compute that we form a set of all x and y values
#of the 2 respective rectangles. if there is an intersection of the x and y
#values the common area is the product of ( biggest common x - smallest common x)
#* ( biggest common y - smallest common y)
my $firstRectXSet = (@first_numbers[0] .. @first_numbers[2]).Set ;
my $firstRectYSet = (@first_numbers[1] .. @first_numbers[3]).Set ;
my $secondRectXSet = (@second_numbers[0] .. @second_numbers[2]).Set ;
my $secondRectYSet = (@second_numbers[1] .. @second_numbers[3]).Set ;
my $commonX = $firstRectXSet (&) $secondRectXSet ;
my $firstArea = (@first_numbers[2] - @first_numbers[0]) *
    (@first_numbers[3] - @first_numbers[1] ) ;
my $secondArea = (@second_numbers[2] - @second_numbers[0]) *
    (@second_numbers[3] - @second_numbers[1] ) ;
if ( $commonX ) {
  my $commonY = $firstRectYSet (&) $secondRectYSet ;
  if ( $commonY ) {
      say ( $firstArea + $secondArea - (( $commonX.max.key - $commonX.min.key )
          * ( $commonY.max.key - $commonY.min.key) )) ;
  }
}
else {
  say ( $firstArea + $secondArea ) ;
}

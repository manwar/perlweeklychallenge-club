use v6 ;

sub enterArray( ) {
  say "Enter an array, items separated by blanks!" ;
  my $line = $*IN.get ;
  my @array = $line.split( /\s+/ ) ;
  return @array ;
}

my @array = enterArray( ) ;
#we fill the array with this value which is not in @array ;
#this denotes that the field in the array wasn't visited yet ;
my $stopvalue = prompt "Enter stop value!" ;
my $len = @array.elems ;
my $dima = floor( sqrt( $len ) ) ;
if ( $len %% $dima ) {
}
else {
  repeat {
      $dima-- ;
  } until ( $len %% $dima ) ;
}
my $dimb = $len div $dima ;
my @spiralarray ; #will hold the items in a spiral
#we fill @spiralarray with the stop value first
for (0 .. $dima - 1 ) {
  my $row ;
  for (0 .. $dimb - 1 ) {
      $row.push( $stopvalue ) ;
  }
  @spiralarray.push( $row ) ;
}
my @directions = ("right" , "up", "left" , "down" ) ;
my $currentIndex = 0 ;#here we start in the array
my $row = $dima - 1 ;#we fill the last row of the spiral array
my $col = 0 ;#we start at column 0 , in the blocks, we use ++$col!
my $diri = 0 ; #index into @directions, we begin with a rightwards move
while ( $currentIndex < $len - 1) {
  if ( @directions[ $diri ] eq "right" ) {
      while (($col < $dimb - 1) and  (@spiralarray[ $row ][$col + 1]
          == $stopvalue) and ($currentIndex < $len - 1 )) {
    @spiralarray[$row][ $col++ ] = @array[$currentIndex++] ;
      }
      if (  $currentIndex == $len - 1 ) {
    if ( $col <= $dimb - 1 and @spiralarray[ $row ][$col] ==
          $stopvalue ) {
        @spiralarray[$row][$col] = @array[ $currentIndex ] ;
    }
      }
  }
  elsif ( @directions[ $diri ] eq "down" ) {
      while ( ($row < $dima - 1) and (@spiralarray[ $row + 1 ][ $col ] ==
          $stopvalue ) and ( $currentIndex < $len - 1 ) ) {
    @spiralarray[ $row++][ $col ] = @array[$currentIndex++] ;
      }
      if ( $currentIndex ==  $len - 1 ) {
    if ( $row <= $dima - 1 and @spiralarray[ $row ][ $col ] ==
          $stopvalue ) {
        @spiralarray[$row][$col] = @array[ $currentIndex] ;
    }
      }
  }
  elsif ( @directions[ $diri ] eq "up" ) {
      while ( ($row > 0 ) and ( @spiralarray[ $row - 1][$col] ==
          $stopvalue ) and ( $currentIndex < $len - 1 )) {
        @spiralarray[$row--][$col] = @array[$currentIndex++] ;
      }
      if ( $currentIndex == $len - 1 ) {
    if ( $row >= 0 and @spiralarray[ $row ][ $col ] ==
          $stopvalue ) {
        @spiralarray[ $row ][ $col ] = @array[ $currentIndex] ;
    }
      }
  }
  elsif ( @directions[ $diri ] eq "left" ) {
      while (($col > 0 ) and (@spiralarray[ $row ][$col - 1 ] ==
          $stopvalue ) and ( $currentIndex < $len - 1 ) ) {
    @spiralarray[$row][$col--] = @array[$currentIndex++] ;
      }
      if (  $currentIndex == $len - 1 ) {
    if ( $col >= 0 and @array[ $row ][ $col ] == $stopvalue ) {
        @spiralarray[$row][$col] = @array[ $currentIndex ] ;
    }
      }
  }
  $diri++ ;
  $diri = $diri % 4 ;
}
my @sorted = @array.sort( {~$^b.chars <=> ~$^a.chars} ) ;
my $maxwidth = @sorted[0].chars ;
for (0 .. $dima - 1 ) -> $i {
  for ( 0 .. $dimb - 1 ) -> $j {
      my $num = @spiralarray[$i][$j] ;
      my $width = $num.Str.chars ;
      print ' ' x ( $maxwidth - $width + 1) ;
      print $num ;
  }
  print "\n" ;
}

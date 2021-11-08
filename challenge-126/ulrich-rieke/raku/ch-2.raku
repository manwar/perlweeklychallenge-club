use v6 ;

sub enterInput( ) {
  say "Enter 5 lines with 10 characters each , only x and * allowed!" ;
  my @lines ;
  for (1 .. 5 ) {
      my $line = $*IN.get ;
      while ( $line !~~ /^ <[x*]> ** 10 $/ ) {
    say "line should be 10 characters long and consist of x and *!" ;
    $line = $*IN.get ;
      }
      @lines.push( $line ) ;
  }
  return @lines ;
}

sub countMines(  $row , $col , @lines ) {
  my $mines = 0 ;
  for ( $row - 1 .. $row + 1 ) -> $currentRow {
      for ( $col - 1 .. $col + 1 ) -> $currentCol {
    if (( -1 < $currentRow < 5 ) and ( -1 < $currentCol < 10 )) {
        if ( @lines[ $currentRow ].substr( $currentCol , 1 ) eq "x" ) {
          $mines++ ;
        }
    }
      }
  }
  @lines[ $row ].substr-rw( $col , 1 ) = ~$mines ;
}

sub MAIN( ) {
  my @lines = enterInput( ) ;
  for (0 .. 4) -> $row {
      for ( 0 .. 9 ) -> $col {
    if ( @lines[ $row ].substr( $col , 1 ) eq "*" ) {
        countMines( $row , $col , @lines) ;
    }
      }
  }
  .say for @lines.map( { $_.comb.join( ' ' ) } ) ;
}

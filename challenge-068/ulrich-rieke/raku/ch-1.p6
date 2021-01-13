use v6 ;

sub findZeroes( @array ) {
  my @zeroes ;
  my $len = @array.elems ;
  for (0..$len - 1 ) -> $i {
      if ( @array[ $i ] eq "0" ) {
    @zeroes.push( $i ) ;
      }
  }
  return @zeroes ;
}

sub enterMatrix( Int $rows, Int $columns ) {
  my @matrix ;
  for (0..$rows - 1 ) -> $r {
      my @row ;
      for (0..$columns - 1 ) -> $col {
    my $num = prompt "Enter 0 or 1: " ;
    while ( ~$num ne "0" && ~$num ne "1" ) {
        say "$num is illegal entry!" ;
        $num = prompt "Enter 0 or 1: " ;
    }
    @row.push( $num ) ;
      }
      say "You entered { @row }." ;
      @matrix.push( @row ) ;
  }
  return @matrix ;
}

sub MAIN( Int $m , Int $n ) {
  my @matrix = enterMatrix( $m , $n ) ;
  my @zerolist ;
  for  @matrix -> @sublist {
      @zerolist.push( findZeroes( @sublist ) ) ;
  }
  for (0..@zerolist.elems - 1 ) -> $i {
      if ( @zerolist[ $i ] ) {
    for (0..$n - 1) -> $col {
        @matrix[ $i ][ $col ] = 0 ; #nullify row
    }
    for @matrix -> @row {
        for (0..@zerolist[ $i ].elems - 1) -> $column {
          @row[ @zerolist[ $i ][$column ]] = 0 ;
        }
    }
      }
  }
  for @matrix -> @aRow {
      @aRow.map( { print "$_ " } ) ;
      say " " ;
  }
}

use v6 ;

#looks for the direction of the next move, depending on the current
#position in the array, the currrent movement and whether the next cell
#to jump to is beyond the borders of the array or has already been visited

sub findDirection( @visited, $currentRow, $currentCol , $nextDir is copy ) {
  state $rows = @visited.elems ;
  state $cols = @visited[0].elems ;
  given $nextDir {
      when "right" { if ($currentCol + 1 < $cols and
                  @visited[$currentRow][$currentCol + 1 ] eq 'n' ) {
                    $nextDir = "right" ;
                      }
                      else {
            $nextDir = "down" ;
              }
                  }
      when "down"  { if ($currentRow + 1 < $rows and
                  @visited[ $currentRow + 1 ][ $currentCol ] eq 'n' ) {
                    $nextDir = "down" ;
                    }
                    else {
            $nextDir = "left" ;
            }
                  }
      when "left"  { if ( $currentCol - 1 > -1 and
                  @visited[ $currentRow][ $currentCol - 1 ] eq 'n' ) {
                    $nextDir = "left" ;
                    }
                    else {
            $nextDir = "up" ;
            }
                  }
      when "up"    { if ( $currentRow - 1 > -1  and
                  @visited[ $currentRow - 1][ $currentCol ] eq 'n' ) {
                    $nextDir = "up" ;
                    }
                    else {
            $nextDir = "right" ;
            }
                  }
  }
  return $nextDir ;
}

sub enterArray( Int $m , Int $n ) {
  my @array ;
  say "Enter the array ( $m lines with $n numbers each!) " ;
  for ( 0 .. $m - 1 ) -> $row {
      my @subarray ;
      say "Enter a row, separated by blanks!" ;
      my $line = $*IN.get ;
      while ( $line.comb.elems < $n ) {
    say "Enter new line!"  ;
    $line = $*IN.get ;
      }
      @subarray.push( |($line.split( /\s/ ))) ;
      @array.push( @subarray ) ;
  }
  return @array ;
}

sub MAIN( Int $m , Int $n ) {
  my @array = enterArray( $m , $n ) ;
  my @visited ; #mark all fields as 'n'ot visited
  for ( 0 .. $m - 1 ) -> $i {
      my @subarray = ('n' xx $n).Array ;
      @visited.push( @subarray ) ;
  }
  my $currentRow = 0 ;
  my $currentCol = 0 ;
  my @list ;
  my $nextDir = "right" ;
  @list.push( @array[ 0 ][ 0] ) ;
  @visited[ 0 ][ 0 ] = 'y' ; #the left upper cell is visited
  repeat {
      $nextDir = findDirection( @visited , $currentRow , $currentCol ,
        $nextDir ) ;
      given $nextDir {
    when "right" { $currentCol++ }
    when "up"    { $currentRow-- }
    when "down"  { $currentRow++ }
    when "left"  { $currentCol-- }
      }
      @visited[ $currentRow ][ $currentCol ] = 'y' ;#mark as visited
      @list.push( @array[ $currentRow ][ $currentCol] ) ;#add to list
  } until ( @list.elems == $m * $n ) ;
  say @list ;
}

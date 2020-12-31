use v6 ;

sub enterTree( ) {
  my @tree ;
  say "Enter tree ( end to end)!" ;
  my $nextLevel = $*IN.get ;
  while ( $nextLevel ne "end" ) {
      @tree.push( $nextLevel ) ;
      $nextLevel = $*IN.get ;
  }
  return @tree ;
}

#is a certain position a leaf ?
#$y stands for the line , $x for postion in line
sub isLeaf( @tree, Int $x , Int $y --> Bool ) {
  if ( $y == @tree.elems - 1 ) {
      return True ;
  }
  else {
      return ( not my $d = @tree[$y + 2].substr( $x + 2 , 1 ) ~~ /\d/
        and not my $e = @tree[$y + 2].substr( $x - 2, 1 ) ~~ /\d/ ) ;
  }
}

#look for a path from a leaf upwards to the root element
#by finding every lead we will be able to find every path
sub findPath( @tree , Int $x is copy , Int $y is copy ) {
  my @path ; #the path from this leaf to root
  my $neighbor = @tree[ $y ].substr( $x , 1 ) ;
  while ( $neighbor ) {
      @path.push( $neighbor ) ;
      my $aboveright = findRightUpper( @tree , $x , $y ) ;
      my $aboveleft = findLeftUpper( @tree, $x , $y ) ;
      if ( not $aboveright and (not $aboveleft) ) {# we are at root
    return @path .= map( {.Int} ) ; #we have completed the path
      }
      else {
    if ( $aboveright ) {
        $neighbor = $aboveright ;
        $x += 2 ; #the next node is further right
    }
    else {
        $neighbor = $aboveleft ;
        $x -= 2 ; #the next node is further left
    }
    $y -= 2 ; #we go up the tree
      }
  }
}

#what do we find at the next node up to the right ?
#we only return a valid value if there is a number
sub findRightUpper( @tree , $x , $y ) {
  my $value = "" ;
  if ( $y - 2 > -1 ) {
      if ( $x + 2 < @tree[$y - 2].chars ) {
    if ( (my $d = @tree[$y - 2].substr( $x + 2 , 1 ) ) ~~ /\d/ ) {
        $value = $d ;
    }
      }
  }
  return $value ;
}

#same to the upper left
sub findLeftUpper( @tree , $x , $y ) {
  my $value = "" ;
  if ( $y - 2 > -1 ) {
      if ( $x - 2 > -1 ) {
    if ( (my $d = @tree[$y - 2].substr( $x - 2 , 1 ) ) ~~ /\d/ ) {
        $value = $d ;
    }
      }
  }
  return $value ;
}

#we look for all leaves in the tree, they can be at any level apart from the
#root level. Every leaf is a starting point for a path.
sub findLeaves( @tree ) {
  my @leaves ;
  my $currentLevel = @tree.elems - 1 ;
  while ( $currentLevel > 2 ) { #this is the highest level where there might be leaves
      for ( 0 .. @tree[ $currentLevel ].chars - 1 ) -> $i {
    if ( @tree[ $currentLevel ].substr( $i , 1 ) ~~ /\d/ ) {
        if ( $currentLevel == @tree.elems - 1 ) {#these are all leaves
          @leaves.push( [$i , $currentLevel] ) ;
        }
        else { #we must check for "leafiness"...
          if ( isLeaf( @tree, $i , $currentLevel ) ) {
          @leaves.push( [$i , $currentLevel] ) ;
          }
        }
    }
      }
      $currentLevel -= 2 ;
  }
  return @leaves ;
}

my @tree = enterTree( ) ;
my @paths ; #that where all the paths from the leaves go
my @leaves = findLeaves( @tree ) ;
for @leaves -> $leaf {
  my @path = findPath( @tree, $leaf[0] , $leaf[1] ) ;
  @paths.push( @path ) ;
}
my @sums = @paths.map( {[+] $_} ) ;
say @sums.sum ;

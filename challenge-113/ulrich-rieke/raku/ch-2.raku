use v6 ;

#we enter the binary tree level by level. That means, that at every level
#numbers are ordered from left to right. To denote different parent nodes,
#we introduce subarrays at every level when needed
sub sumElements( $element ) {
  my $sum = 0 ;
  for (0 .. $element.elems - 1) -> $i {
      if ( $element[ $i ] ~~ Int ) {
    $sum += $element[ $i ] ;
      }
      if ( $element[ $i ] ~~ Array ) {
    $sum += [+] |$element[ $i ] ;
      }
  }
  return $sum ;
}

sub calculateElement( $element , $sum ) {
  my $output ;
  for (0 .. $element.elems - 1 ) -> $i {
      if ( $element[ $i ] ~~ Int ) {
    $output.push( $sum - $element[ $i ] ) ;
      }
      if ( $element[ $i ] ~~ Array ) {
    my $restsums ;
    for (0 .. $element[ $i ].elems - 1) -> $j {
        $restsums.push( $sum - $element[$i][$j] ) ;
    }
    $output.push( $restsums ) ;
      }
  }
  return $output ;
}

my @binary_input = ( [1] , [2 , 3] , [[4] , [5 , 6 ]] , [7] ) ;
#we substitute every node by the sum of all nodes - the node itself
#due to the rooting and ordering principles of a binary tree this brings
#about a reverse ordering of the tree
my $treesum = 0 ;
@binary_input.map( { $treesum += sumElements( $_ ) } ) ;
my @output_binary = @binary_input.map( { calculateElement( $_ , $treesum) }) ;
say @output_binary ;

use v6 ;

subset Positive of Int where * > 0 ;
sub MAIN( Positive $m is copy , Positive $n is copy ) {
  say " " ;
  my @currentRow ;
  my $maximumWidth = ($m * $n).Str.chars + 1 ;
  my $maxFirstColumnWidth = $m.Str.chars + 1 ;
  @currentRow.push( sprintf( "%-*s" , $maxFirstColumnWidth ,  "x" ) ) ;
  @currentRow.push( "|" ) ;
  for (1 .. $n) -> $i {
    @currentRow.push( sprintf( "%*d", $maximumWidth,  $i )) ;
  }
  @currentRow.join.say ;
  print "-" x $maxFirstColumnWidth ;
  print "+" ;
  say "-" x ( $maximumWidth * $n ) ;
  my @allProducts ;
  @currentRow = ( ) ;
  for (1 .. $m) -> $i {
      @currentRow.push(sprintf("%-*s" , $maxFirstColumnWidth , "$i")) ;
      @currentRow.push( "|" ) ;
      for (1 .. $n) -> $j {
    @currentRow.push( sprintf("%*d" , $maximumWidth, $i * $j )) ;
    @allProducts.push( $i * $j ) ;
      }
      @currentRow.join.say ;
      @currentRow = ( ) ;
  }
  my $distinctTerms = @allProducts.Set ;
  say " " ;
  say "Distinct Terms: " ~ $distinctTerms.keys.sort.join(", ") ;
  say "Count: {$distinctTerms.elems}" ;
}

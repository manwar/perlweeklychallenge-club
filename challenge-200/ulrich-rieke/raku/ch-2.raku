use v6 ;

sub MAIN( Int $number is copy ) {
  my @digits ;
  while ( $number != 0 ) {
      @digits.push( $number % 10 ) ;
      $number div= 10 ;
  }
  @digits .=reverse ;
  my @truth = <abcdef bc abdeg abcdg bcfg acdfg a cdefg abc abcdefg abcfg> ;
  my @selected ; #which truth elements are in the number entered ?
  for @digits -> $n {
      if ( $n <= 5 ) {
    @selected.push( @truth[ $n ] ) ;
      }
      else {
    @selected.push( @truth[ $n + 1 ] ) ;
      }
  }
  my $finalLetterOrder ;#if a segment is printed , put '1' , else put 0
#starting with a, then f, b and so on
  for <a f b g e c d> -> $aChar {#this is the order to observe
      for @selected -> $table {
    my $set = $table.comb.Set ; #set of letters in the selected entry
    if ( $aChar (elem) $set ) {
        $finalLetterOrder ~= '1' ;
    }
    else {
        $finalLetterOrder ~= '0' ;
    }
      }
  }
  my $len = @digits.elems ;
  for (0..$len - 1 ) -> $pos {#print 'a' segment
      if ( $finalLetterOrder.substr( $pos , 1 ) eq '1' ) {
    print '-' x 7 ;
      }
      else {
    print ' ' x 7 ;
      }
      print ' ' x 3 ;#print interdigit space
  }
  say ' ' ;
  for (1..2) -> $i {#print 'f' and 'b' segment twice
      for ($len..2 * $len - 1 ) -> $pos {
    if ( $finalLetterOrder.substr( $pos , 1 ) eq '1' ) {
        print '|' ;
    }
    else {
        print ' ' ;
    }
#if 'f' is printed we must see whether 'b' segment in the same row is activated
#so we have to look $len elements ahead   
    if ( $finalLetterOrder.substr( $pos + $len , 1 ) eq '1' ) {
        print ' ' x 5 ~ '|' ;
    }
    else {
        print ' ' x 6 ;
    }
    print ' ' x 3 ;
      }
      say ' ' ;
  }
  for (3 * $len .. 4 * $len - 1 ) -> $pos {#print 'g' , same logic as for 'a'
    if ( $finalLetterOrder.substr( $pos , 1 ) eq '1' ) {
    print '-' x 7 ;
      }
      else {
    print ' ' x 7 ;
      }
      print ' ' x 3 ;
  }
  say ' ' ;
  for (1..2 ) -> $i { #print 'e' and 'c', same logic as for 'f' and 'b'
      for (4 * $len .. 5 * $len - 1 ) -> $pos {
    if ( $finalLetterOrder.substr( $pos , 1 ) eq '1' ) {
        print '|' ;
    }
    else {
        print ' ' ;
    }
    if ( $finalLetterOrder.substr( $pos + $len , 1 ) eq '1' ) {
        print ' ' x 5 ~ '|' ;
    }
    else {
        print ' ' x 6 ;
    }
    print ' ' x 3 ;
      }
      say ' ' ;
  }
  for (6 * $len .. 7 * $len - 1 ) -> $pos {#print 'd' , as 'g' or 'a'
      if ( $finalLetterOrder.substr( $pos , 1 ) eq '1' ) {
    print '-' x 7 ;
      }
      else {
    print ' ' x 7 ;
      }
      print ' ' x 3 ;
  }
  say ' ' ;
}

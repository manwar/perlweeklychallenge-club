use v6 ;

class Node {
  has Int $.value is rw ;
  has Node $.next is rw ;
}

class LinkedList {
  has Node $.first is rw ;
  has Node $.last is rw ;
  has Int $.size is rw ;

  method createList( @array ) {
      my $current ;
      my $next ;
      $.size = @array.elems ;
      my $firstTime = True ;
      $.last = Node.new( value => @array[*-1] ) ;
      while ( @array ) {
    $current = Node.new( value => @array.shift ) ;
    $next.next = $current if $next ;
    if ( @array ) {
        $next = Node.new( value => @array.shift ) ;
        $current.next = $next ;
        if ( $firstTime ) {
          $.first = $current ;
          $firstTime = False ;
        }
    }
      }
  }

  method removeAt( Int $k ) {
      if ( $k == 1 ) {
    $.first .= next ;
      }
      if ( $k == $.size ) {
    my $current = $.first ;
    my $n = 1 ;
    while ( $n < $k - 1  ) {
        $current .= next ;
        $n++ ;
    }
    $current.next = Nil ;
      }
      if ( 1 < $k < $.size ) {
    my $n = 1 ;
    my $current = $.first ;
    while ( $n < $k - 1 ) {
        $current .= next ;
        $n++ ;
    }
    $current.next = $current.next.next ;
      }
  }

  method toString( --> Str ) {
      my $current = $.first ;
      my @terms ;
      while ( defined $current ) {
    @terms.push( $current.value.Str ) ;
    $current = $current.next ;
      }
      return @terms.join('->')
  }
}

sub enterList( ) {
  my Int @array ;
  say "Enter a list of integers ( end to end ) " ;
  my $line = $*IN.get ;
  while ( $line ne "end" ) {
      @array.push( $line.Int ) ;
      $line = $*IN.get ;
  }
  return @array ;
}

sub MAIN( Int $N ) {
  my Int @nums = enterList( ) ;
  say @nums ;
  my $ll = LinkedList.new( ) ;
  $ll.createList( @nums ) ;
  if ( $N > $ll.size ) {
    $ll.removeAt( 1 ) ;
  }
  else {
    $ll.removeAt( $ll.size - $N + 1 ) ;
  }
  say $ll.toString( ) ;
}

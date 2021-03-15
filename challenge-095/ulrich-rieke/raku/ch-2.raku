use v6 ;

class Stack {
  has Mu @!elements ;

  method top(--> Mu ) {
      return @!elements[0] ;
  }

  method pop(--> Mu ) {
      return @!elements.shift ;
  }

  method push( Mu $data ) {
      @!elements.unshift( $data ) ;
  }

  method min(--> Mu ) {
      return @!elements.min ;
  }

  method isEmpty(--> Bool ) {
      return @!elements.elems == 0 ;
  }
}

my Stack $sta = Stack.new( elements => ( ) ) ;
$sta.push( 1 ) ;
$sta.push( 19 ) ;
$sta.push( 44 ) ;
say $sta.top( ) ;
say $sta.pop( ) ;
$sta.push( -33 ) ;
say "The top element is { $sta.top( ) }!" ;
say "The minimum element is { $sta.min( )  } !" ;

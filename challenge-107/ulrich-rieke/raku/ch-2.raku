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

my Stack $st .= new ;
say "The methods of class Stack are " ~ $st.^methods.map( {.gist}).join(", ")
~ " !";

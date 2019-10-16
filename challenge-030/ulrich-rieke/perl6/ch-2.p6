use v6 ;

my @triples ;
for (1..10) -> $a {
  for (1..10) -> $b {
      for (1..10) -> $c {
    my @treble.push($a , $b , $c ) ;
    @treble .= sort ;
    @triples.push( @treble ) if ( (([+] @treble) == 12) &&
          (@treble.grep( { $_ %% 2 } ).elems > 0) ) ;
    }
  }
}
say @triples.unique(:with(&[eqv])) ;

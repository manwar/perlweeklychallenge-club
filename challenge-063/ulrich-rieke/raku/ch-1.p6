use v6 ;

sub last_word( Str $string , Regex $rgx --> Str ) {
  my $result = $string.split( /\s+/ ).reverse.first: * ~~ $rgx ;
  if $result {
      return $result ;
  }
  else {
      return "undef" ;
  }
}

say last_word('  Hello world',    rx/<[ea]>l/) ;
say last_word("Don't match too much, Chet!",  rx:i/ch.t/);
say last_word( join( ' ', 1..1e6) , rx/^(3.*?)** 3/ ) ;

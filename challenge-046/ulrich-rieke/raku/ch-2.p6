use v6 ;

sub flip( $state ) {
  return $state eq "open" ?? "closed" !! "open"  ;
}

my @current = "open" xx 500 ;
for (2..500) -> $i {
  if ( $i < 251 ) {
      for ($i , 2 * $i  ... 500 ) -> $j {
    @current[ $j - 1 ] = flip( @current[ $j - 1] ) ;
      }
  }
  else {
      @current[ $i - 1 ] = flip( @current[ $i - 1 ] ) ;
  }
}
my @doors = @current Z (1..500) ;
for @doors -> $pair {
  say "door {$pair[ 1 ]} is open!" if $pair[0] eq "open" ;
}

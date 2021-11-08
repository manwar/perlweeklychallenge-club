use v6 ;

sub MAIN( ) {
  say "Enter two sets of integers which should be unique!" ;
  my $line = $*IN.get ;
  my @S1 = $line.split( /\s+/ ).unique ;
  say "second set:" ;
  $line = $*IN.get ;
  my @S2 = $line.split( /\s+/ ).unique ;
  if ( @S1.Set (&) @S2.Set == set( ) ) {
      say 1 ;
  }
  else {
      say 0 ;
  }
}

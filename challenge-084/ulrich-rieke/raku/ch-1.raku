use v6 ;

sub MAIN (Str $N ) {
  $N ~~ /(<[+-]>*)(\d+)/ ;
  my $maximum = 2147483647 ;
  if ( $N.Int <= $maximum ) {
      say ($0.Str ~ $1.Str.flip) ;
  }
  else {
      say 0 ;
  }
}

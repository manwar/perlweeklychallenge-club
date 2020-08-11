use v6 ;

sub MAIN( Str $filename ) {
  my $fh = open $filename , :r ;
  try $fh.get ;
  if ( $! ) {
      say "The file is binary." ;
  }
  else {
      say "The file is ascii." ;
  }
}

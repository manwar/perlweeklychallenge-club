use v6 ;

sub MAIN( Str $file, Int $A , Int $B) {
  unless "$file".IO ~~:e {
      note "file $file doesn't exist!" ;
      exit 1 ;
  }
  my $n = 1 ;
  my @lines ;
  for $file.IO.lines -> $line {
      if ( $A <= $n <= $B ) {
    @lines.push( $line ) ;
      }
      if ( $n > $B ) {
    last ;
      }
      $n++ ;
  }
  .say for @lines ;
}

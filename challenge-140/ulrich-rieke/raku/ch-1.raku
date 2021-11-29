use v6 ;

sub infix:<+>( Str $theFirst is copy,  Str $theSecond is copy ) {
  my $sum = ($theFirst.parse-base( 2 ) , $theSecond.parse-base( 2 )).sum ;
  +$sum.base( 2 )
}

sub MAIN( Str $theFirst is copy , Str $theSecond is copy ) {
  while ( $theFirst !~~ /^ <[01]>+ $/ && $theSecond !~~ /^ <[01]>+ $/ ) {
      say "the binary numbers should contain only 0 and 1!" ;
      say "re-enter again! first number:" ;
      $theFirst = $*IN.get ;
      say "second number:" ;
      $theSecond = $*IN.get ;
  }
  say ($theFirst + $theSecond) ;
}

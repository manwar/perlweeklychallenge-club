use v6 ;

sub isReversible( Int $n --> Bool ) {
  my $num = ~$n ;
  my $sum = $n + $num.comb.reverse.join.Int ;
  return so ~$sum.comb.grep( {$_.Int %% 2 } ).none ;
}

say (1 .. 100).Array.grep( {isReversible( $_ ) } ).join( ',' ) ;

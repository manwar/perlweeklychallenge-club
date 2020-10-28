use v6 ;

sub MAIN( Str $S ) {
  my @words = $S.words ;
  my $arraylen = @words.elems ;
  my $stringlen = 0 ;
  @words[1..$arraylen - 2].map( {$stringlen += $_.chars } ) ;
  say $stringlen ;
}

use v6 ;

say "enter a number of words!" ;
my $S = $*IN.get ;
my @S = $S.split( /\,\s/ ) ;
my %anagrams ;
if ( @S.elems == 1 ) {
  say "[ (@S[0]) ]" ;
}
else {
  while ( @S ) {
      my $word = @S.shift ;
      my $reordered = $word.comb.sort.join ;
      %anagrams{$reordered}.push( $word ) ;
  }
  print "[" ;
  for %anagrams.values -> $value {
      print "($value.join( ", ")),\n" ;
  }
  print "]\n" ;
}

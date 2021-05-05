use v6 ;

sub sortLetters( Str $word is copy) {
  return $word.lc.comb.sort({ $^a cmp $^b }).join ;
}

sub MAIN( $infile ) {
  my $fh = $infile.IO.open ;
  die "Couldn't find $infile!" unless ( $fh.IO.e ) ;
  my Str $longestUnchanged = " " ;
  while ( my Str $line = $fh.get ) {
      if ( $line !~~ /^$/ ) {
    if ( $line eq sortLetters( $line ) ) {
        if ( $line.chars > $longestUnchanged.chars ) {
          $longestUnchanged = $line ;
        }
    }
      }
  }
  $fh.close ;
  say "The longest English word which doesn't change by sorting its"
      ~ " letters is $longestUnchanged!" ;
}

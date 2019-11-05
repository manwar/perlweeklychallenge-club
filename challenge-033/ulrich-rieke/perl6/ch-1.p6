use v6 ;

sub MAIN( *@ARGS )  {
  for @ARGS -> $file {
      if $file.IO.e {
    my %lettercount ;
    my @words ;
    for $file.IO.lines -> $line {
        @words = $line.split( /\s+/ ) ;
        for @words -> $word {
          my $lowletter = $word.lc ;
          $lowletter ~~ s:g/<-[a..z]>// ;
          my @letters = $lowletter.comb ;
          for @letters -> $letter {
          %lettercount{ $letter }++ ;
          }
        }
    }
    my @sorted = %lettercount.keys.sort( { $^a leg $^b } ) ;
    say "letter frequency in file $file :" ;
    for @sorted -> $letter {
        say "$letter: %lettercount{ $letter }" ;
    }
      }
      else {
    say "Couldn't open file $file!" ;
      }
  }
}

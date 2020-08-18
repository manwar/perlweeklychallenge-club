use v6 ;

sub MAIN( Str $S ) {
  my %letterfrequencies ;
  my $FNR ;
  my @letters = $S.comb ;
  while ( @letters ) {
      my $currentLetter = @letters.shift ;
      %letterfrequencies{ $currentLetter }++ ;
      if ( %letterfrequencies{ $currentLetter } == 1 ) {
    $FNR ~= $currentLetter ;
      }
      if ( %letterfrequencies{ $currentLetter } > 1 ) {
    my @uniqueLetters = %letterfrequencies.keys.grep( {
          %letterfrequencies{$_} == 1 } ) ;
        #how many unique letters did we find ?
    my $number_of_FNR = @uniqueLetters.elems ;
        #if we find only 1 unique letter, we add it at the end of $FNR
    given $number_of_FNR  {
        when 1 { $FNR ~= @uniqueLetters[ 0 ] }
        #if we find more than 1 unique letter we go back in the $FNR string
        #until we get to a letter that occurred only once at that pos.
        when * > 1 { my $len = $FNR.chars ;
          my $i = $len - 1 ;
          repeat { $i-- } until ( $FNR.substr( $i , 1 ) (elem)
          @uniqueLetters.Set ) ; $FNR ~= $FNR.substr( $i , 1 ) }
        when 0 { $FNR ~= '#' }
    }
      }
  }
  say $FNR ;
}

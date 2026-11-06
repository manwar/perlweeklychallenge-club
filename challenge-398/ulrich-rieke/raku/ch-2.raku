use v6 ;

sub create_differences( $word is copy ) {
   my $len = $word.chars ;
   my @differences ;
   for (1..$len - 1) -> $pos {
      @differences.push( ord( $word.substr( $pos )) -
            ord( $word.substr( $pos - 1 ))) ;
   }
   return @differences ;
}

say "Enter some words with equal length > 1 !" ;
my $line = $*IN.get ;
my @allWords = $line.words ;
my %frequencies ; # frequencies for letter differences 
my %difffrequencies ; # letter differences for every word
for @allWords -> $wd {
   my @diffs = create_differences( $wd ) ;
   my $stringified = @diffs.join( ',' ) ;
   %difffrequencies{$wd} = $stringified ;
}
%difffrequencies.values.map( {%frequencies{$_}++} ) ;
my @selected = %frequencies.keys.grep( {%frequencies{$_} == 1} ) ;
my $solution ;
for @allWords -> $wd {
   if ( %difffrequencies{$wd} eq @selected[0] ) {
      $solution = $wd ;
   }
}
say $solution ;

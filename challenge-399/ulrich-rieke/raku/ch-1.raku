use v6 ;

sub letter_frequency( $word ) {
   my %frequencies ;
   for $word.comb -> $letter {
      %frequencies{$letter}++ ;
   }
   return %frequencies ;
}

sub create_substrings( $word , $l ) {
   my @substrings ;
   my $len = $word.chars ;
   for (0..$len - $l - 1 ) -> $start {
      for ($l .. $len - $start ) -> $howmany {
         @substrings.push( $word.substr( $start , $howmany ) ) ;
      }
   }
   return @substrings ;
}

sub analyze_frequencies( %freq ) {
   my @retvalue ;
   my $most_frequent = %freq.values.max ;
   my $total = 0 ;
   for %freq.keys -> $key {
      if ( %freq{$key} != $most_frequent ) {
         $total += %freq{$key} ;
      }
   }
   @retvalue.push( $most_frequent ) ;
   @retvalue.push( $total ) ;
   return @retvalue ;
}

say "Enter a word with capital characters and a positive integer!" ;
my $line = $*IN.get ;
my ($word , $num ) = $line.words ;
my $k = $num.Int ;
my %letterfreqs = letter_frequency( $word ) ;
if ( %letterfreqs.keys.elems == 1 ) { #only one character!
   say $word.chars ;
}
elsif ( %letterfreqs.keys.elems == $word.chars ) { #consisting of different characters!
   say ($k + 1 ) ;
}
else {
#create all the substrings ; then determine the letter frequencies for every substring
#and select those substrings in which the sum of the frequencies of all letters 
#that are not the most frequent , equals $k
   my @all_subs = create_substrings( $word , $k ) ;
   my @all_frequencies ;
   for @all_subs -> $sub {
      @all_frequencies.push( letter_frequency( $sub ) ) ;
   }
   my @pairs ;
   for @all_frequencies -> %freq {
      @pairs.push( analyze_frequencies( %freq ) ) ;
   }
   my @selected ;
   for @pairs -> @p {
      if ( @p[1] == $k ) {
         @selected.push( @p ) ;
      }
   }
   my @sorted = @selected.sort( {@^b[0] <=> @^a[0]}  ) ;
   say ( @sorted[0][0] + @sorted[0][1] ) ;
}

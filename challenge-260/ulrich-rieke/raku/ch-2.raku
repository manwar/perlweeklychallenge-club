use v6 ;

say "Enter a word, preferably in capital letters only!" ;
my $word = $*IN.get ;
my %permuHash ;
for $word.comb.permutations -> $permu {
   %permuHash{ $permu.join( '' )}++ ;
}
my @sorted = %permuHash.keys.sort ;
my $pos = 0 ;
repeat {
   $pos++ ;
} until ( @sorted[ $pos - 1] eq $word ) ;
say $pos ;

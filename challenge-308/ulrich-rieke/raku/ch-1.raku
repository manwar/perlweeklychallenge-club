use v6 ;

say "Enter some words separated by whitespace!" ;
my $line = $*IN.get ;
my @firstWords = $line.words ;
say "Enter some more words separated by whitespace!" ;
$line = $*IN.get ;
my @secondWords = $line.words ;
my %firstHash ;
@firstWords.map( {%firstHash{$_}++} ) ;
my %secondHash ;
@secondWords.map( {%secondHash{$_}++} ) ;
my $common = 0 ;
for %firstHash.keys -> $word {
   if ( %secondHash{$word}:exists ) {
      $common++ ;
   }
}
say $common ;

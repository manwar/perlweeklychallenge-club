use v6 ;

say "Enter some words separated by whitespace!" ;
my $line = $*IN.get ;
my @singleWords = $line.words ;
my @charSets = @singleWords.map( {$_.comb.Set} ) ;
my $common = [(&)] @charSets ;
my @commonLetters = $common.keys ;
my %frequencies ;
for @singleWords -> $word {
   my %wordfreq ;
   for $word.comb -> $letter {
      %wordfreq{$letter}++ ;
   }
   for @commonLetters -> $letter {
      %frequencies{$letter}.push( %wordfreq{$letter} ) ;
   }
}
my @solution ;
for %frequencies.keys -> $l {
   for (1..%frequencies{$l}.min( ) ) {
      @solution.push( $l ) ;
   }
}
say '(' ~ @solution.join( ',' ) ~ ')' ;

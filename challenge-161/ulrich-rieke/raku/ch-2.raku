use v6 ;

sub isOneLetterWord( Str $word is copy --> Bool ) {
  my %letterFreq ;
  my $letterSet = $word.comb.Set ;
  return $letterSet.elems == $word.chars ;
}

my $file = "dictionary.txt" ;
my $fh = open $file , :r or die "Can't find file $file!" ;
my @oneLetterWords ;
for $fh.lines -> $line {
  if ( isOneLetterWord( $line ) ) {
      @oneLetterWords.push( $line ) ;
  }
}
$fh.close ;
my @solutionShort ;
my @solutionLong ;
for ( 'a' .. 'z' ) -> $letter {
  my @sorted = @oneLetterWords.grep( { $_ ~~ /^$letter/ } ).sort( { $^a.chars
    <=> $^b.chars } ) ;
  @solutionShort.push( @sorted[ 0 ] ) ;
  @solutionLong.push( @sorted[ *-1 ] ) ;
}
say "We consider only words in the dictionary without repeated letters in them!" ;
say "We add one word per letter, and then a short solution is:" ;
say @solutionShort.join(',') ;
my $sum = 0 ;
@solutionShort.map( { $sum += $_.chars } ) ;
say "This contains $sum letters!" ;
say "A solution with long words is:" ;
say @solutionLong.join( ',' ) ;
$sum = 0 ;
@solutionLong.map( { $sum += $_.chars } ) ;
say "This contains $sum letters!" ;

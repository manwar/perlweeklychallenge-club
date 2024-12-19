use v6 ;

say "Enter some words separated by blanks!" ;
my $line = $*IN.get ;
my @words = $line.words ;
say "Enter a sentence!" ;
my $sentence = $*IN.get ;
my @sentencewords = $sentence.words ;
my $changedsentence ;
for @sentencewords -> $s {
   my $changed = False ;
   for @words -> $w {
      if ( $s ~~ /^$w/ ) {
	 $changedsentence ~= $w ;
	 $changed = True ;
      }
   }
   unless ( $changed ) {
      $changedsentence ~= $s ;
   }
   $changedsentence ~= " " ;
}
say $changedsentence ;

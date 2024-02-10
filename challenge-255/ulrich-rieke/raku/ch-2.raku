use v6 ;

say "Enter a paragraph of words, enter <return> to end!" ;
my @paragraph ;
my $line = $*IN.get ;
while ( $line ) {
   @paragraph.push( $line ) ;
   $line = $*IN.get ;
}
say "Enter a banned word!" ;
my $banned = $*IN.get ;
my %frequencies ;
for @paragraph -> $sentence {
   my @words = $sentence.words ;
   for @words <-> $word {
      $word ~~ s/(.+)<-[a..z]>$/$0/ ;
      %frequencies{ $word }++ ;
   }
}
my @sorted = %frequencies.keys.sort( {%frequencies{$^b} <=> %frequencies{$^a} } ) ;
if ( @sorted[0] ne $banned ) {
   say @sorted[0] ;
}
else {
   say @sorted[1] ;
}


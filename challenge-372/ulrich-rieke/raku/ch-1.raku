use v6 ;

say "Enter a text with some words surrounded by spaces!" ;
my $text = $*IN.get ;
my $totalspaces = $text.comb.grep( {$_ eq ' '} ).elems ;
$text ~~ s/^\s+// ;
$text ~~ s/\s+$// ;
my $output ;
if ( $text ~~ /\s/ ) {
   my @words = $text.words ;
   my $len = @words.elems ;
   my $gapspaces = $totalspaces div ( $len - 1 ) ;
   for (0..$len - 2) -> $pos {
      $output ~= @words[$pos] ~ (' ' x $gapspaces) ;
   }
   $output ~= @words[*-1] ~ (' ' x ($totalspaces * ( $len - 1 ))) ;
}
else {
   $output = $text ~ ' ' x $totalspaces ;
}
say $output ;

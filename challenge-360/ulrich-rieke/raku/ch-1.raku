use v6 ;

say "Enter a word!" ;
my $word = $*IN.get ;
say "Enter a width!" ;
my $wword = $*IN.get ;
my $width = $wword.Int ;
my $output ;
my $len = $word.chars ;
if ( $len == 0 ) {
   for (0..$width - 1) {
      $output ~= '*' ;
   }
}
else {
   my $left = ( $width - $len ) div 2 ;
   for (0..$left - 1) {
      $output ~= '*' ;
   }
   $output ~= $word ;
   for (0..$width - $len - $left - 1 ) {
      $output ~= '*' ;
   }
}
$output.say ;

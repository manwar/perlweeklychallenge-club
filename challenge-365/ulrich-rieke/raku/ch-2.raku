use v6 ;

sub is_valid( $word ) {
   my $condition1 = $word ~~ /^\D+$/ ;
   my $condition2 ;
   if ( $word ~~ /'-'/ ) {
      $condition2 = $word.index("-" ) != $word.chars - 1 && $word ~~
         /<[a..z]>\-<[a..z]>/ && $word.comb.grep( {$_ eq '-'} ).elems == 1 ;
   }
   else {
      $condition2 = True ;
   }
   my $condition3 ;
   if ( $word ~~ /<[!,.]>/ ) {
      $condition3 = $word ~~ /<[!,.]>$/ ;
   }
   else {
      $condition3 = True ;
   }
   return $condition1 && $condition2 && $condition3 ;
}

say "Enter a sentence!" ;
my $line = $*IN.get ;
say $line.words.grep( {is_valid( $_)} ).elems ;

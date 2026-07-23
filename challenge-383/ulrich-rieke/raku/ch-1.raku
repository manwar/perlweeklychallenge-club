use v6 ;

sub are_similar( @firstWords , @secondWords , %similarities ) {
   if ( @firstWords.elems != @secondWords.elems ) {
      return False ;
   }
   else {
      my $l = @firstWords.elems ;
      my @selected ;
      for (0..$l - 1 ) -> $pos {
         if ( @firstWords[$pos] ne @secondWords[$pos] ) {
            @selected.push( $pos ) ;
         }
      }
      if ( not @selected ) {
         return True ;
      }
      else {
         my @chosen = @selected.grep( {%similarities{@firstWords[$_]}:exists 
               && contains( %similarities{@firstWords[$_]} , @secondWords[$_] )} ) ;
         return @chosen.elems == @selected.elems ;
      }
   }
}

sub contains( @array , $word ) {
   for @array -> $w {
      if ( $w eq $word ) {
         return True ;
      }
   }
   return False ;
}


say "Enter a first list of strings separated by blanks!" ;
my $line = $*IN.get ;
my @firstwords = $line.words ;
say "Enter a second list of strings separated by blanks!" ;
$line = $*IN.get ;
my @secondwords = $line.words ;
say "Enter a list of lists, each list separating words by blanks!" ;
say "Enter <newline> at end of entry!" ;
my @similars ;
$line = $*IN.get ;
while ( $line ) {
   @similars.push( $line.words ) ;
   $line = $*IN.get ;
}
my %similarities ;
for @similars -> @sublist {
   for @sublist[1..@sublist.elems - 1] -> $el {
      %similarities{@sublist[0]}.push( $el ) ;
   }
}
say are_similar( @firstwords , @secondwords , %similarities ) || are_similar( 
      @secondwords , @firstwords , %similarities ) ;

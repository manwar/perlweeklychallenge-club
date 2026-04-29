use v6 ;

sub find_missing( @letters ) {
   my @diffs ; 
   my $len = @letters.elems ;
   for (1..$len - 1) -> $pos {
      if ( (@letters[$pos - 1] ne "?") && (@letters[$pos] ne "?" )) {
         @diffs.push( @letters[$pos].ord( ) - @letters[$pos - 1].ord( )) ;
      }
   }
   my %uniques ;
   for @diffs -> $num {
      %uniques{$num}++ ;
   }
   my $question_pos ;
   for (0..$len - 1 ) -> $pos {
      if ( @letters[$pos] eq '?' ) {
         $question_pos = $pos ;
         last ;
      }
   }
   if ( %uniques.keys.elems == 1 ) { #only one difference
      if ( $question_pos == 0 ) {
         return (@letters[1].ord - @diffs[0]).chr ;
      }
      else {
         return (@letters[$question_pos - 1].ord + @diffs[0]).chr ;
      }
   }
   else { #alternating differences
      @diffs = (@diffs xx 2).flat ;
      if ( $question_pos == 0 ) {
         return ( @letters[1].ord - @diffs[0]).chr ;
      }
      else {
         return ( @letters[$question_pos - 1].ord + @diffs[$question_pos - 1]).
            chr ;
      }
   }
}

say find_missing( ('a' , 'c' ,  '?' ,  'g' ,  'i' ) ) ;
say find_missing( ('a' , 'd' , '?' , 'j' , 'm' ) ) ;
say find_missing( ('a' , 'e' , '?' , 'm' , 'q' ) ) ;
say find_missing(( 'a' , 'c' ,  'f' ,  '?' ,  'k')) ;
say find_missing( ('b' ,  'e' ,  'g' ,  '?' ,  'l' ) ) ;

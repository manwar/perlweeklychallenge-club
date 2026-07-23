use v6 ;

sub replaceAll ( $original is copy , @positions , $replacement ) {
   my @letters = $original.comb ;
   my $n = 0 ;
   for @positions -> $p {
      @letters[$p] = $replacement[ $n ] ;
      $n++ ;
   }
   return @letters.join ;
}

say "Enter a string consisting of 0 , 1 and ? only!" ;
my $word = $*IN.get ;
if ( $word !~~ /'?'/ ) {
   say '(' ~ $word ~ ')' ;
}
else {
   my $question_mark_num = $word.comb.grep( { $_ eq '?' } ).elems ;
   my @replace_combis ;
#create an array with as many 0 and 1 as there are question marks!
   for (0..$question_mark_num - 1 ) {
      @replace_combis.push( '0' ) ;
      @replace_combis.push( '1' ) ;
   }
   my @question_mark_pos ;
   for (0..$word.chars - 1 ) -> $pos {
      if ( $word.substr( $pos , 1 ) eq "?" ) {
         @question_mark_pos.push( $pos ) ;
      }
   }
#find all combinations of n of @replace_combis , where n is the number of 
#question marks
   my %unique_words ;
   my @all_combis = @replace_combis.combinations( $question_mark_num ) ;
   for @all_combis -> $combi {
      %unique_words{ replaceAll( $word , @question_mark_pos , $combi ) }++ ;
   }
   my @sorted = %unique_words.keys.sort ;
   say '(' ~ @sorted.join( ',' ) ~ ')' ;
}

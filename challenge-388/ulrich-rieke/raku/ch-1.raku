use v6 ;

say "Enter a number!" ;
my $numberline = $*IN.get ;
my $number = $numberline.Int ;
if ( $number == 0 ) {
   say '""' ;
}
else {
   my $current ;
   for (0..$number - 1) {
      $current ~= "U" ;
      $current ~= "D" ;
   }
   my %found ;
   my @permus = $current.comb.permutations ;
   my $permuword ;
   for @permus -> $permuseq {
      for (0..2 * $number - 1 ) -> $i {
         $permuword ~= $permuseq[$i] ;
      }
      if ( condition( $permuword ) ) {
         %found{$permuword}++ ;
      }
      $permuword = "" ;
   }
   say "(" ~ %found.keys.sort.join( ',' ) ~ ")" ;
}

sub count( $word is copy , $letter ) {
   return $word.comb.grep( {$_ eq $letter} ).elems ;
}

sub condition( $word is copy ) {
   for (1..$word.chars - 1 ) -> $i {
      if ( count( $word.substr( 0 , $i ) , 'D' ) > count( $word.substr( 0 , $i ) ,
               'U' )) {
         return False ;
      }
   }
   return True ;
}

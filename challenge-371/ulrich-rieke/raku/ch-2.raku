use v6 ;

say "Enter some integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $len = @numbers.elems ;
my @pairs ;
for (1..$len ) -> $i {
   @pairs.push( ($i , @numbers[$i - 1] )) ;
}   
my @result ;
for (2..$len - 1 ) -> $d {
   my @combis = @pairs.combinations( $d ) ;
   for @combis -> $subseq {
      my @vals ;
      my $indexsum = 0 ;
      my $numbersum = 0 ;
      for (0..$subseq.elems - 1)  -> $i {
         $indexsum += $subseq[$i][0] ;
         $numbersum += $subseq[$i][1] ;
         @vals.push( $subseq[$i][1] ) ;
      }
      if ( $indexsum == $numbersum ) {
         say @vals ;
         @result.push( '(' ~ @vals.join( ',' ) ~ ')' ) ;
      }
   }
}
say '(' ~ @result ~ ')' ;

use v6 ;

say "Enter some integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
say "Enter a positive integer!" ;
$line = $*IN.get ;
my $num = +$line ;
my $len = @numbers.elems ;
my @solution ;
my $total = $len div $num ;
my $remainder = $len % $num ;
if ( $total == 0 ) {
   say -1 ;
}
else {
   my $result ;
   my $rest ;
   if ( $remainder != 0 ) {
      $result = @numbers[0..$remainder * ( $total + 1) - 1].rotor($total
            + 1 ) ;
      $rest = @numbers[$remainder * ($total + 1)..$len - 1].rotor( $total ) ;
   }
   else {
      $result = @numbers.rotor( $total ) ;
   }
   for (0..$result.elems - 1) -> $el {
      @solution.push( '(' ~ $result[$el].join(',') ~ ')') ;
   }
   if ( $rest ) {
      for (0..$rest.elems - 1) -> $el {
         if ( $rest[$el].elems > 1 ) {
            @solution.push( '(' ~ $rest[$el].join( ',' ) ~ ')' ) ;
         }
         else {
            @solution.push( '(' ~ $rest[$el] ~ ')' ) ;
         }
      }
   }
   say '(' ~ @solution.join( ',' ) ~ ')' ;
}

use v6 ;

say "Enter some integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $len = @numbers.elems ;
my @result ;
my $current_sum = 0 ;
for (0..$len - 1 ) -> $pos {
   $current_sum += @numbers[ $pos ] ;
   @result.push( $current_sum ) ;
}
say "(" ~ @result.join( ',' ) ~ ")" ;

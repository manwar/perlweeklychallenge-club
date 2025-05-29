use v6 ;

say "Enter an income!" ;
my $inline = $*IN.get ;
my $income = $inline.Int ;
say "Enter , separated by blanks , two numbers in brackets, separated by blanks!";
say "Do it like that [a,b] [c,d] !" ;
my $nextline = $*IN.get ;
my @brackets = $nextline.words ;
my @pairs ;
for @brackets -> $br {
   if ( $br ~~ /^ '[' (\d+) \s* ',' \s* (\d+) ']' $/ ) {
      my ( $number , $tax ) = ( +$0 , +$1 ) ;
      @pairs.push( ($number , $tax) ) ;
   }
}
my @differences ; #for the differences between the first elements of @pairs
@differences.push( @pairs[0][0] ) ;
for (1..@pairs.elems - 1 ) -> $index {
   @differences.push( @pairs[$index][0] - @pairs[$index - 1][0] ) ;
}
my @taxparts ; #for the parts of income that fall into every tax category
my $sum = 0 ; #sum up the elements of @differences until at least $income
my $index = 0 ;
while ( $sum < $income ) {
   @taxparts.push( @differences[$index] ) ;
   $sum += @differences[$index] ;
   $index++ ;
}
if ( $sum > $income ) {
   my $last = @taxparts.pop ;
   @taxparts.push( $last - ( $sum - $income ) ) ;
}
my $totaltax = 0 ;
for (0..@taxparts.elems - 1 ) -> $i {
   $totaltax += @taxparts[ $i ] * @pairs[$i][1] / 100 ;
}
say $totaltax ;

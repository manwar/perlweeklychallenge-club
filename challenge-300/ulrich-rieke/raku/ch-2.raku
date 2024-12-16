use v6 ;

sub find_set_lengths( @numbers , $index is copy ) {
   my %set ;
   while ( not (%set{@numbers[$index]}:exists )) {
      %set{@numbers[$index]}++ ;
      $index = @numbers[$index] ;
   }
   return %set.elems ;
}

say "Enter a permutation of positive integers 0..n-1!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $len = @numbers.elems ;
my @lengths ;
for (0..$len - 1 ) -> $i {
   my $num = find_set_lengths( @numbers , $i ) ;
   @lengths.push( $num ) ;
}
say @lengths.max ;

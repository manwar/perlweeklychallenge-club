use v6 ;

say "Enter some integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @for_sorting = @numbers ;
@for_sorting.sort( {$^a <=> $^b} ) ;
my $permus = permutations( @for_sorting ) ;
my $len = $permus.elems ;
my $i = 0 ;
while ( $permus[$i].Array != @numbers ) {
   $i++ ;
}
#the original number sequence corresponds to the last permutation of the
#sorted numbers , then go back to the first permutation!
if ( $i == $len - 1 ) {
   say $permus[0] ;
}
else {
   say $permus[$i + 1] ;
}

use v6 ;

say "Enter some numbers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Real} ) ;
my @sorted = @numbers.sort ;
my @differences ;
for (1..@sorted.elems - 1 ) -> $pos {
    @differences.push( @sorted[$pos] - @sorted[$pos - 1] ) ;
}
say so @differences[0] == @differences.all ;

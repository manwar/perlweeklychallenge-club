use v6 ;

say "Enter some integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @sorted = @numbers.sort( {$^a <=> $^b} ) ;
my @neighbours ;
my $len = @numbers.elems ;
for (0..$len - 2) -> $first {
    for ($first + 1 .. $len - 1 ) -> $second {
        @neighbours.push( (@sorted[$first] , @sorted[$second] ) ) ;
    }
}
my $mindiff = @neighbours.map( {$_[1] - $_[0]} ).min ;
my @result = @neighbours.grep( {($_[1] - $_[0]) == $mindiff } ) ;
say @result ;

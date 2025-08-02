use v6 ;

say "Enter some integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @unique_numbers = @numbers.sort( {$^a <=> $^b} ).unique ;
my @pairs = (1..@unique_numbers.elems) Z, @unique_numbers ;
my @solution ;
for @numbers -> $n {
   @solution.push( @pairs.grep( {$_[1] == $n} ).map( {$_[0]} )) ;
}
say '(' ~ @solution.join( ',' ) ~ ')' ;

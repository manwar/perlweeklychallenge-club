use v6 ;

say "Enter some integers, separated my blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $len = @numbers.elems ;
my @solution ;
for (0..$len - 1 ) -> $index {
   my @selected = @numbers.grep( { $_ < @numbers[ $index ] } ) ;
   @solution.push( @selected.elems ) ;
}
say "(" ~ @solution.join( ',' ) ~ ")" ;

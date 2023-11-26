use v6 ;

say "Enter some positive integers, separated by blanks!" ;
say "numbers should be from 0 to the length of the array - 1!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @newNumbers ;
for (0..@numbers.elems - 1) -> $i {
   my $num = @numbers[ $i ] ;
   @newNumbers.push( @numbers[ $num ] ) ;
}
say "(" ~ @newNumbers.join( ',' ) ~ ")" ;

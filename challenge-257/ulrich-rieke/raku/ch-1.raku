use v6 ;

say "Enter some integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @result ;
for @numbers -> $num {
   @result.push( @numbers.grep( { $_ < $num } ).elems ) ;
}
say "(" ~ @result.join( ',' ) ~ ")" ;

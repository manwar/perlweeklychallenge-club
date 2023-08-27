use v6 ;

say "Enter some integers, separated by blanks!" ;
my $line = $*IN.get( ) ;
my @numbers = $line.words.map( {.Int} ) ;
my $mini = @numbers.min ;
my $maxi = @numbers.max ;
my @selected = @numbers.grep( { $_ != $mini && $_ != $maxi } ) ;
if ( @selected.elems == 0 ) {
   say -1 ;
}
else {
   say "(" ~ @selected.join( ',' ) ~ ")" ;
}

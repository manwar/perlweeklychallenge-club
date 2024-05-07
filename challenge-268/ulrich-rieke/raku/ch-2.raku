use v6 ;

say "Enter an even number of integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @target ;
while ( @numbers.elems > 0 ) {
    @numbers .= sort( {$^a  <=> $^b } ) ;
    my ( $smallest , $secsmallest ) = @numbers.splice( 0 , 2 ) ;
    @target.push( $secsmallest , $smallest ) ;
}
say "(" ~ @target.join( ',' ) ~ ")" ;

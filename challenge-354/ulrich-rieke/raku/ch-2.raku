use v6 ;

say "Enter a m x n matrix , <return> to end entry!" ;
my @allElements ;
my $line = $*IN.get ;
my $columns ;
while ( $line ) {
    my @numbers = $line.words.map( {.Int} ) ;
    $columns = @numbers.elems ;
    @numbers.map( {@allElements.push( $_ ) } ) ;
    $line = $*IN.get ;
}
say "How many shifts should there be ?" ;
$line = $*IN.get ;
my $shifts = +$line ;
my @shifted ;
@allElements.map( {@shifted.push( $_)} ) ;
for (0..$shifts - 1) {
    @shifted = @shifted.rotate( - 1 ) ;
}
say '(' ;
for @shifted.rotor($columns ) -> $seq {
    say " [" ~ $seq ~ "]" ;
}
say ')' ;

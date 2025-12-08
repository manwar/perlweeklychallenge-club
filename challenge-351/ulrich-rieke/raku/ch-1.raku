use v6 ;

sub find( @array , $element ) {
    my $pos = 0 ;
    while ( @array[$pos] != $element ) {
        $pos++ ;
    }
    return $pos ;
}

say "Enter some numbers seperated by blanks!" ;
my $numberline = $*IN.get ;
my @numbers = $numberline.words.map( {.Int} ) ;
if (so @numbers[0] == @numbers.all) {
    say "0" ;
}
else {
    my $maxi = @numbers.max ;
    my $pos = find( @numbers , $maxi ) ;
    @numbers.splice( $pos , 1 ) ;
    my $mini = @numbers.min ;
    $pos = find( @numbers , $mini ) ;
    @numbers.splice( $pos , 1 ) ;
    say ([+] @numbers) / @numbers.elems ;
}



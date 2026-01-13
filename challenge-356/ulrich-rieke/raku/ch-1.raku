use v6 ;

say "Enter an integer greater than 3!" ;
my $line = $*IN.get ;
my $number = +$line ;
my @kolakoski ;
my $i = 1 ;
while ( @kolakoski.elems < $number ) {
    if ( not @kolakoski ) {
        @kolakoski.push( 1 ) ;
    }
    else {
        my $pushed = False ;
        if ( @kolakoski.elems < $i ) {
            @kolakoski.push( $i ) ;
            $pushed = True ;
        }
        if ( not $i %% 2 ) {
            if ( not $pushed ) {
                for (0..@kolakoski[$i - 1] - 1 ) {
                    @kolakoski.push( 1 ) ;
                }
            }
            else {
                @kolakoski.push( 1 ) ;
            }
        }
        else {
            if ( not $pushed ) {
                for (0..@kolakoski[$i - 1] - 1) {
                    @kolakoski.push( 2 ) ;
                }
            }
            else {
                @kolakoski.push( 2 ) ;
            }
        }
    }
    $i++ ;
}
say @kolakoski[0..$number -1].grep( {$_ == 1} ).elems ;


#!raku

# fusc(0) = 0
# fusc(1) = 1
# for n > 1:
# when n is even: fusc(n) = fusc(n / 2),
# when n is odd: fusc(n) = fusc((n-1)/2) + fusc((n+1)/2)


multi sub fusc( 0 ) { 0 }
multi sub fusc( 1 ) { 1 }
multi sub fusc( $n where { $n > 1 } ) {
    return samewith( ( $n / 2 ).Int ) if $n %% 2;
    return samewith( ( ( $n - 1 ) / 2 ).Int ) + samewith( ( ( $n + 1 ) / 2 ).Int );
}


sub MAIN(){
    "fusc( $_ ) = { fusc( $_ )}".say for 0 .. 10;
}

#!raku


sub MAIN( Int $N where { $N > 0 } ) {

    my @numbers = lazy gather {
        for 1 .. Inf {
            next if $_ ~~ / (11)+ /;
            next if $_ ~~ / <[04..9]> /;
            
            take $_;
            
        }
    }

    @numbers[ $N - 1 ].say;
}

#!raku

sub MAIN( Int $N where { $N > 0 },
          Int $D where { $D >= 0 && $D.Str.chars == 1 } ) {
    given (1 ..^ $N).grep( * ~~ / $D /).sum {
        when $N { '1'.say }
        default { '0'.say }
    }
    
}

#!/usr/bin/env raku

sub MAIN(UInt $N where 2 <= $N <= 5) {
    my @A = [0, 1];

    loop {
        state $C = 2;
    
        my @S1 = @A>>.fmt("%0" ~ $C ~ "b");

        my @S2 = @A>>.fmt("%0" ~ $C - 1 ~ "b").reverse.map("1" ~ *);

        @S1.append(@S2);

        @A = @S1.map({ ":2<$_>".Int }); #https://tinyurl.com/y3nw4q5j 

        last if $C++ == $N;
    }

    say @A;
}

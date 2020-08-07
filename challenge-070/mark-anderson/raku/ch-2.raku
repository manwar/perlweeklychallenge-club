#!/usr/bin/env raku

sub MAIN(UInt $N where 2 <= $N <= 5) {
    my @A = [0, 1];

    for 2..$N {
        my @S1 = @A.map("0" ~ *);

        my @S2 = @A.reverse.map("1" ~ *);

        @A = @S1.append(@S2);
    }

    say @A.map({ ":2<$_>".Int }).Array; #https://tinyurl.com/y3nw4q5j 
}

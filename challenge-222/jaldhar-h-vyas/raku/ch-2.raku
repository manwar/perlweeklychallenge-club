#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my @sorted = @ints.sort({ $^b <=> $^a });

    until @sorted.elems < 2 {
        if @sorted[0] == @sorted[1] {
            @sorted = @sorted.splice(2).sort({ $^b <=> $^a });
        } else {
            my $new = @sorted[0] - @sorted[1];
            @sorted = @sorted.splice(2).push($new).sort({ $^b <=> $^a });
        }
    }

    say @sorted ?? @sorted[0] !! 0;
}

#!/usr/bin/raku

sub MAIN(
    *@args
) {
    my @ints = @args;

    while @ints.elems > 1 {
        @ints = @ints.sort({ $^b <=> $^a });

        my $y = @ints[0];
        my $x = @ints[1];

        if $x == $y {
            @ints.splice(0, 2);
        } else {
            @ints.splice(1, 1);
            @ints[0] = $y - $x;
        }
    }

    say @ints[0] // 0;
}


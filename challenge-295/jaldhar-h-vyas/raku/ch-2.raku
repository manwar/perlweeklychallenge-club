#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my $maxJumps = @ints[0];
    my $step = @ints[0];
    my $jumps = 1;

    for 1 ..^ @ints.end -> $i {
        if $i + @ints[$i] > $maxJumps {
            $maxJumps = $i + @ints[$i];
        }
        $step--;

        if $step == 0 {
            $jumps++;
            if $i >= $maxJumps {
                $jumps = -1;
                last;
            }
            $step = $maxJumps - $i;
        }
    }
    say $jumps;
}
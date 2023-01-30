#!/usr/bin/raku

sub partitions(Int $n) {
    my @combos;
    my @piles;
    my $i = 0;
    @piles[$i] = $n;

    loop {
        @combos.push([@piles]);

        my $remainder = 0;
        while ($i >= 0 && @piles[$i] == 1) {
            $remainder += @piles[$i];
            $i--;
        }

        if ($i < 0) {
            last;
        }

        @piles[$i]--;
        $remainder++;

        while ($remainder > @piles[$i]) {
            @piles[$i + 1] = @piles[$i];
            $remainder = $remainder - @piles[$i];
            $i++;
        }
        @piles[$i + 1] = $remainder;
        $i++;
    }

    return @combos;
}

sub MAIN(
    Int $n where { $n > 0; } #= an integer greater than zero
) {
    say partitions($n).elems;
}
#!/usr/bin/raku

sub MAIN(
    *@n #= a list of integers
) {
    my @previous = @n[1 .. *];
    my $total;

    while @previous.elems {
        $total = @previous[0];
        my @next = ( $total );

        for 1 ..^ @previous.elems -> $i {
            $total += @previous[$i];
            @next.push($total);
        }

        @previous = @next[1 .. *];
    }

    say $total;
}
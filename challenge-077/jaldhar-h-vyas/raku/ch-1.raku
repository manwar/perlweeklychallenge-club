#!/usr/bin/raku

sub find($n, @fibs, @current, $start) {
    if $n == 0 && @current {
        say @current.join(q{ + }), " = ", @current.sum;
        return 1;
    }

    my $found = 0;

    for $start .. @fibs.end -> $i {
        if @fibs[$i] > $n {
            next;
        }
        $found += find($n - @fibs[$i], @fibs,
            @current.clone.push(@fibs[$i]), $i + 1);
    }

    return $found;
}

sub MAIN(
    $N
) {
    my @fibs = (1, 2, -> $a, $b { $a + $b} ... ∞)[^$N];
    unless find($N, @fibs, [], 0) {
        say 0;
    };

}

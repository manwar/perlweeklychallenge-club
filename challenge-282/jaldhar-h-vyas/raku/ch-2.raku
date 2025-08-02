#!/usr/bin/raku

sub MAIN(
    $str
) {
    my @chars = $str.lc.comb;
    my $current = @chars.shift;
    my $changes = 0;

    for @chars -> $c {
        if $c ne $current {
            $changes++;
            $current = $c;
        }
    }

    say $changes;
}
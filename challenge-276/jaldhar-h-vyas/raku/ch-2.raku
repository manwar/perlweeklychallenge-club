#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my %freq;

    for @ints -> $int {
        %freq{$int}++;
    }

    my $max = 0;
    my $output = 0;

    for %freq.kv -> $k, $v {
        if $v > $max {
            $max = $v;
            $output = 1;
        } elsif $v == $max {
            $output++;
        }
    }

    say $output;
}
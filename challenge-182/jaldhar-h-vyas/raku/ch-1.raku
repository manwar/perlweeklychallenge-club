#!/usr/bin/raku

sub MAIN(
    *@n #= a list of integers
) {
    my $max = -∞;
    my $index;

    for @n.pairs -> $i {
        if $i.value > $max  {
            $max = $i.value;
            $index = $i.key;
        }
    }

    say $index;
}
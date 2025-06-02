#!/usr/bin/raku

sub MAIN(
    *@operations
) {
    my $total = 0;

    for @operations -> $operation {
        if $operation ~~ /\+\+/ {
            $total++;
        }
        if $operation ~~ /\-\-/ {
            $total--;
        }
    }

    say $total;
}
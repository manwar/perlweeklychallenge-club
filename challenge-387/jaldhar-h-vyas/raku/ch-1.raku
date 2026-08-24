#!/usr/bin/raku

sub MAIN(
    $str is copy
) {
    my $steps = 0;

    while $str ~~ s:g/01/10/ {
        $steps++;
    }

    say $steps;
}
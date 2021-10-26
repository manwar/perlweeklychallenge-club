#!/usr/bin/raku

sub MAIN(
    Int $N
) {
    my $n = $N.subst(/^\-/, q{});

    if $n !~~ /^ \d+ $/ {
        die "$n Not an integer.\n";
    }

    my $len = $n.chars;

    if $len % 2 == 0 {
        die "Even number of digits\n";
    }

    if $len < 3 {
        die "Too short.\n";
    }

    say $n.substr(($len - 3) / 2, 3);
}

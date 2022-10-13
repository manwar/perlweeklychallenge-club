#!/usr/bin/raku

sub zip(@a, @b) {
    return (@a Z @b).flat.list;
}

sub MAIN() {
    my @a = qw/1 2 3/;
    my @b = qw/a b c/;

    say zip(@a, @b);
    say zip(@b, @a);
}
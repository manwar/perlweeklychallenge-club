#!/usr/bin/raku

sub MAIN(Int $N) {
    my $next = $N + 1;
    do $next++ until $next == $next.flip;
    say $next;
}
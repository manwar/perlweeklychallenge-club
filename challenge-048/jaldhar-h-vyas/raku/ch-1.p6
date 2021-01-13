#!/usr/bin/perl6

multi sub MAIN() {
    my @people = (0 .. 49);

    my $remaining = @people.elems;
    my $next = 0;
    my $victim = 1;

    while $remaining > 1 {
        @people[$victim] = Nil;
        $remaining--;
        repeat {
            $next = ($next + 1) % 50;
        } until defined @people[$next];

        $victim = $next;
        repeat {
            $victim = ($victim + 1) % 50;
        } until defined @people[$victim];
    }

    say @people.grep({ defined $_; })[0] + 1;
}
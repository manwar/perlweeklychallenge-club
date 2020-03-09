# Test: perl6 ch-2.p6
use v6.d;

sub MAIN() {
    my @solutions;

    for (2 ... 9) -> $h {
        for (2 .. 9) -> $t {
            for (2 .. 9) -> $o {
                if ( $h * $t != $t * $o &&
                     $h * $t != $h * $t * $o &&
                     $h * $o != $h * $t * $o &&
                     $t * $o != $h * $t * $o ) {
                    push @solutions, "$h$t$o";
                }
            }
        }
    }

    say @solutions.join(" ");
}

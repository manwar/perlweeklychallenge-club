#!/usr/bin/raku
use MONKEY-SEE-NO-EVAL;

sub MAIN(
    Str $input #= a representation of a triangle array as nested arrays
) {
    my @levels = EVAL $input;
    my $count = 0;
    my $i = 0;

    for @levels -> @level {
        if @level[$i] < (@level[$i + 1] // ∞) {
            $count += @level[$i];
        } else {
            $count += @level[$i + 1];
            $i = $i + 1;
        }
    }

    say $count;
}
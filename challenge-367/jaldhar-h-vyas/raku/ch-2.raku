#!/usr/bin/raku

sub MAIN(
    Str $s1,
    Str $e1,
    Str $s2,
    Str $e2,
) {
    constant ONE_DAY = 86_400;

    my ($start1, $end1, $start2, $end2) =
        ($s1, $e1, $s2, $e2).map({ DateTime.new("1970-01-02T$($_):00Z") });

    if $start1 > $end1 {
        $start1 -= Duration.new(ONE_DAY);
    }

    if $start2 > $end2 {
        $start2 -= Duration.new(ONE_DAY);
    }

    say ($start1.Instant < $end2.Instant && $start2.Instant < $end1.Instant);
}

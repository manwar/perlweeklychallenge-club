#!/usr/bin/raku

sub MAIN(
    Int $m,
    Int $n
) {
    my $mlength = $m.chars;
    my $nlength = $n.chars;
    my $mnlength = ($m * $n).chars;
    my %terms;

    say sprintf("% {$mlength + 2}s", 'x |'),
        (1 .. $n).fmt("% {$mnlength}s", q{ });
    say q{-} x $mlength + 1, q{+},  q{-} x ($n * ($mnlength + 1) - 1);

    for (1 .. $m) -> $em {
        printf("% {$mlength}s |", $em);
        for (1 .. $n) -> $en {
            my $term = $em * $en;
            %terms{$term}++;
            printf("% {$mnlength}s ", $term);
        }
        print("\n");
    }
    print("\n");

    say 'Distinct Terms: ', %terms.keys.sort({ $^a <=> $^b }).join(q{, });
    say 'Count: ', %terms.keys.elems;
}

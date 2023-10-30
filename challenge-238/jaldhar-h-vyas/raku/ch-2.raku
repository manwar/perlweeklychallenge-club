#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my %steps;

    for @ints -> $int {
        my $n = $int;
        my $s = 0;
        while $n.chars > 1 {
            $n = [*] ($n.comb);
            $s++;
        }
        %steps{$int} = $s;
    }

    my @sorted = %steps.keys.sort({ %steps{$^a} <=> %steps{$^b} || $^a > $^b });

    say q{(}, @sorted.join(q{, }), q{)};
}
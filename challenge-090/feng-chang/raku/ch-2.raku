#!/bin/env raku

sub MAIN(UInt:D $A, UInt:D $B) {
    my ($a, $b) = ($A, $B);
    my $aw = $a.chars;
    my $bw = ($b * $a).chars;
    my @R;

    repeat {
        put "{ $a.fmt("%{ $aw }d") } & { $b.fmt("%{ $bw }d") }";
        @R.push([$a, $b]);

        $a div= 2;
        $b   *= 2;
    } while $a > 0;

    put '-' x ($aw + $bw + 3);

    my @S = @R.grep({ .[0] !%% 2 }).map({ .[1] });
    put @S.join(' + '), ' = ', @S.sum;
}

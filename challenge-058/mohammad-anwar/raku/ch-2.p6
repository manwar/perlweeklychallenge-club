#!/usr/bin/env perl6

use v6.d;

sub MAIN() {
    my $H = [2, 6, 4, 5, 1, 3];
    my $T = [1, 0, 2, 0, 1, 2];
    my $O = order-lineup({ H => $H, T => $T });

    say sprintf("\@H = (%s)", $H.join(", "));
    say sprintf("\@T = (%s)", $T.join(", "));
    say sprintf("\@O = (%s)", $O.join(", "));
}

sub order-lineup($args) {

    my @H = $args.{'H'}.<>;
    my @T = $args.{'T'}.<>;

    my %H-T = ();
    for 0 .. @H.elems-1 -> $i {
        %H-T{@H[$i]} = @T[$i];
    }

    my $O = [];
    for %H-T.sort(*.keys).reverse -> $r {
        my $h = $r.kv[0];
        my $t = $r.kv[1];

        my $i = 0;
        my $j = 0;
        while $t > $j {
            $j++ if $O.[$i] > $h;
            $i++;
        }

        $O.splice: $i, 0, $h.Int;
    }

    return $O;
}

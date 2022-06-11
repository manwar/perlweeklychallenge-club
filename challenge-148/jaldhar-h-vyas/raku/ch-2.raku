#!/usr/bin/raku

sub MAIN() {
    my $count = 0;
    for 1 .. 100 -> $a {
        for 1 .. 100 -> $b {
            for 1 .. 100 -> $c {
                my $bc = $b * sqrt($c);
                my $left = ($a + $bc) ** (1/3);
                my $x = $a - $bc;
                my $right = $x >= 0 ?? $x ** (1/3) !! -$x.abs ** (1/3);
                if ($left + $right).round(0.001) == 1.0 {
                    $count++;
                    ($a, $b, $c).join(q{, }).say;
                    if $count > 4 {
                        exit;
                    }
                }
            }
        }
    }
}

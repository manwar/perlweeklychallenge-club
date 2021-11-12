#!/usr/bin/raku

sub lychrel(Int $n) {

    my $i = $n;
    for 1 .. 500 {
        my $r = $i.comb.reverse.join;
        $i =  $i + $r;

        if $i == $i.comb.reverse.join {
            return 0;
        }

        if $i > 10_000_000 {
            return 1;
        }
    }

    return 1;
}

sub MAIN(
    Int $n where { $n >= 10 && $n <= 1000 } #= integer between 10 and 1000
) {
    say lychrel($n);
}
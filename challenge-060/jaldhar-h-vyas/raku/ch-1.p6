#!/usr/bin/perl6

multi sub MAIN(
    Str $column #= string of capital letters only
    where { $column ~~ / ^ <[A..Z]>+ $/ }
) {
    my @chars = $column.flip.comb;
    my $output = 0;

    for 0 ..^ @chars.elems -> $i {
        $output +=
            (@chars[$i].ord() - 'A'.ord() + 1) * 26 ** $i;
    }
    say $output;
}

multi sub MAIN(
    Int $num    #= integer > 0
    where {$num > 0 }
) {
    my $output = 'A';

    for 1 ..^  $num {
        $output++;
    }
    say $output;
}
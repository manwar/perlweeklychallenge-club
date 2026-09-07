#!/usr/bin/raku

sub MAIN(
    $n
) {
    my @participants = 1 .. $n;
    my $count = 0;

    for (1 .. $n).permutations -> $perm {
        if  (@participants Z== @$perm).all == False {
            $count++;
        }
    }

    say $count;
}
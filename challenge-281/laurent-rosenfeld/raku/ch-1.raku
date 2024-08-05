sub check-color ($in) {
    my ($abscissa, $ordinate) = $in.comb;`
    my $code;
    given $abscissa {
        when /<[aceg]>/ {$code = 0}
        when /<[bdfh]>/ {$code = 1}
    }
    return True if ($code + $ordinate) %% 2;
    False;
}

for <a1 d3 g5 e6 h8> -> $coordinates {
    printf "%-2s => ", $coordinates;
    say check-color $coordinates;
}

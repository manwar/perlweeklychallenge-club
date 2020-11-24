sub array-of-product (@N) {
    my $p = [*] @N;
    return @N.map(-> $n { $p / $n });
}

my @examples = [
    [5, 2, 1, 4, 3],
    [2, 1, 4, 3],
    [1, 3, 3, 7],
];

for @examples -> @N {
    say "Input  @N = { @N.gist }";
    say "Output @M = " ~ array-of-product(@N).gist;
    say "----";
}

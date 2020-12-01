sub array-of-product (@N) {
    my $zeros = @N.grep(-> $n { $n == 0 }).elems;

    my $q = [*] @N.grep(-> $n { $n != 0 });

    my $fun;

    if $zeros == 0 {
        $fun = -> $n { $q / $n };
    } elsif $zeros == 1 {
        $fun = -> $n { $n == 0 ?? $q !! 0 };
    } else {
        $fun = -> $n { 0 };
    }

    return @N.map($fun);
}

my @examples = [
    [5, 2, 1, 4, 3],
    [2, 1, 4, 3],
    [1, 3, 3, 7],
    [1, 3, 0, 3, 7],
    [1, 3, 0, 3, 7, 0],
];

for @examples -> @N {
    say "Input  @N = { @N.gist }";
    say "Output @M = " ~ array-of-product(@N).gist;
    say "----";
}

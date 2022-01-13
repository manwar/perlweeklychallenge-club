# This definitely is not efficient, but it displays the power of Raku syntax.

sub MAIN($a, $b, $n) {
    say (sort 1..$a X* 1..$b)[$n - 1]
}

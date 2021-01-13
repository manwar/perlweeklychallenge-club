#!/usr/bin/env raku

#| Given two integers $m and $n. Prints all possible combinations of $n numbers from the list 1 2 3 … $m.
sub MAIN (
    UInt $m, #= End of range
    UInt $n, #= Size of returned lists
) {
    .join(",").say for (1..$m).combinations($n);
}

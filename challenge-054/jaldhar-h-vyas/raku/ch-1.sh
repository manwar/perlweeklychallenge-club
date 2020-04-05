perl6 -e 'my ($n, $k) = @*ARGS; (1 .. $n).permutations[$k - 1].join(q{}).say;' $@

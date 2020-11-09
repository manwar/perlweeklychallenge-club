perl6 -e 'say @*ARGS.combinations(3).grep({ ([+] @_) ~~ 1.0 .. 2.0 }).elems ?? 1 !! 0;' $@

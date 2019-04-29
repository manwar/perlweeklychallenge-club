my $dict = "/usr/share/dict/words".IO.lines()>>.lc.Set;
for @*ARGS ?? @*ARGS !! ! $*IN.t ?? lines() !! '' -> $w {
    $w.lc.comb.permutations>>.join.grep({ $dict{$_} and $_ ne $w }).map({ "$w\t$_\n" }).unique.join.say;
}

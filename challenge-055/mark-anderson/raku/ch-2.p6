use MONKEY-SEE-NO-EVAL;

sub MAIN(*@array where @array.all ~~ /^\d+$/) {
    for @array.permutations.map(~*).unique {
        .say if EVAL (.comb(/\d/) <<Z~>> (" >= ", " <= "))
        .subst(/\s.\=\s$/, q{});
    }
}

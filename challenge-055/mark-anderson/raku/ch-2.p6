use MONKEY-SEE-NO-EVAL;

sub MAIN(*@array where @array ~~ /\d/) {
    my @strings = @array.permutations.map(~*).unique;

    for @strings -> $string {
        my $str = $string.subst(/ \s (\d) \s (\d) /, { ">= $0 <= $1" }, :g);
        $str = $str.subst(/ (\d) \s (\d) $ /,  { "$0 >= $1" });
        say $string if EVAL $str;
    }
}

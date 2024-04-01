sub factorial(Int $n) {
    return [*] 1..$n;
}

sub dictionary-rank(Str $word) {
    my $length = $word.chars;
    my %char-counts = $word.comb.Bag;
    my $rank = 1;

    for 0..$length-1 -> $i {
        my $char = $word.substr($i, 1);
        my $smaller-chars = [+] %char-counts.pairs.grep({ .key lt $char }).map(*.value);

        $rank += $smaller-chars * factorial($length - $i - 1)
                 / [*] %char-counts.values.map({ factorial($_) });

        %char-counts{$char}--;
        %char-counts{$char}:delete if %char-counts{$char} == 0;
    }

    return $rank;
}

say dictionary-rank('CAT');
say dictionary-rank('GOOGLE');
say dictionary-rank('SECRET');

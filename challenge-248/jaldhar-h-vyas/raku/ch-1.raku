#!/usr/bin/raku

sub MAIN(
    $letter,
    $str
) {
    my @chars = $str.comb;
    my @j = @chars.keys.grep({ @chars[$_] eq $letter });
    say q{(},
        @chars.keys.map({ my $i = $_; @j.map({ abs($i - $_) }).min; })
        .join(q{,}),
        q{)};
}
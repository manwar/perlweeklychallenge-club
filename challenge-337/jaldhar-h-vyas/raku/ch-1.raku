#!/usr/bin/raku

sub MAIN(
    *@num1
) {
    my %sorted;

    for @num1.sort({ $^a <=> $^b }).kv.reverse -> $k, $v {
        %sorted{$k} //= $v;
    }

    say q{(}, @num1.map({ %sorted{$_} }).join(q{, }), q{)};
}
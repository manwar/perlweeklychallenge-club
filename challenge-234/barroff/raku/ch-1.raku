#!/usr/bin/env raku

use v6.d;

sub common-characters(*@words --> Seq) {
    my $wb = [∩] map({ Bag($_.comb) }, @words);
    my $final-string = [~] map({ $_ x $wb{$_} }, keys $wb);
    return (sort $final-string.comb);
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is common-characters("java", "javascript", "julia"), ("a", "j"),
        'works for ("java", "javascript", "julia")';
    is common-characters("bella", "label", "roller"), ("e", "l", "l"),
        'works for ("bella", "label", "roller")';
    is common-characters("cool", "lock", "cook"), ("c", "o"),
        'works for ("cool", "lock", "cook")';
}

#| Take user provided list like aba aabb abcd bac aabc
multi sub MAIN(*@words where @words.elems ≥ 1) {
    my Str @swords = @words;
    say common-characters(@swords);
}

#!/usr/bin/env raku

multi sub infix:<buds> (Str() $source,
                        Str() $target where $target.codes != $source.codes) {
    return False
}
multi sub infix:<buds> (Str() $source,
                        Str() $target where $target.codes <= 1) {
    return False
}
multi sub infix:<buds> (Str() $source, Str() $target) {
    my @target = $target.comb.Array;
    my @check = $source.comb.Array;
    my $last = $target.codes;
    for 0..^$last -> $first {
        for $first^..^$last -> $second {
            @check[$first,$second] = @check[$second,$first];
            return True if @check ~~ @target;
            @check[$first,$second] = @check[$second,$first];
        }
    }
    return False;
}

multi sub MAIN(:t(:$test) where ?* ) is hidden-from-USAGE {
    use Test;
    ok !("123" buds "1"), "Different Lengths";
    ok !("1" buds "2"), "Too Short";
    ok "fcuk" buds "fuck", "Exmaple 1";
    ok "eovl" buds "love", "Swap anything";
    ok !("love" buds "love"), "Example 2";
    ok "fodo" buds "food", "Example 3";
    ok "feed" buds "feed", "Example 4";
    done-testing;
}

#|(Given two strings prints if they are buddy strings
or not. They are buddy string if swapping two
letters makes them the same.)
multi sub MAIN(
    Str $source #= Source string
    ,Str $target #= Target string
) {
    say $source buds $target;
}



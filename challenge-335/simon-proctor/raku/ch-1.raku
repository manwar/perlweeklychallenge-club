#!/usr/bin/env raku

multi sub MAIN(:t(:$test)) is hidden-from-USAGE {
    use Test;
    is common-chars("bella", "label", "roller"), ("e", "l", "l");
    is common-chars("cool", "lock", "cook"), ("c", "o");
    is common-chars("hello", "world", "pole"), ("l", "o");
    is common-chars("abc", "def", "ghi"),();
    is common-chars("aab", "aac", "aaa"),("a", "a");
    done-testing;
}

multi sub common-chars( *@words where all(@words) ~~ Str ) {
    common-chars(@words);
}

multi sub common-chars( @words where all(@words) ~~ Str ) {
    return ( [(&)] @words.map( *.comb.Bag ) ).map( -> $p { |($p.key xx $p.value) } ).sort;
}

#| Given a list of strings print an orders list of the common characters
multi sub MAIN( *@words where all(@words) ~~ Str ) {
    common-chars(@words).join(",").say;
}

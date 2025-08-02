#!/usr/bin/env raku

multi sub MAIN(:t(:$test) where ?* ) is hidden-from-USAGE {
    use Test;
    is last-word("The Weekly Challenge"),9;
    is last-word("   Hello   World    "),5;
    is last-word("Let's begin the fun"),3;
    is last-word(""),0;
    is last-word("     "),0;
    done-testing;
}

#|(Given a string find the length of the last word in it)
multi sub MAIN(
    Str $s #= A string made of one or more words
) {
    say last-word($s);
}

#|(Joins the arguments with spaces and gives the length of the last word)
multi sub MAIN(
    *@s where ?@s #= A string made of one or more words
) {
    say last-word(@s.join(" "));
}

subset Blank of Str where m/^ \s* $/;

multi sub last-word(Blank $) { 0 }
multi sub last-word(Str $s) { $s.comb(/\S+/)[*-1].codes }


#!/usr/bin/env raku
use Test;

is replace-words(<cat bat rat>, "the cattle was rattle by the battery"), "the cat was rat by the bat";
is replace-words(<a b c>, "aab aac and cac bab"), "a a a c b";
is replace-words(<man bike>, "the manager was hit by a biker"), "the man was hit by a bike";

sub replace-words(@words, $sentence is copy)
{
    @words.map(-> $w { $sentence .= subst(/ << $w.*? >> /, $w, :g) }); 
    return $sentence 
}

#!/usr/bin/env raku
use Test;

is str-diff(<ab bc cd zy>),         "zy";
is str-diff(<cba fed azy>),         "azy";
is str-diff(<pop ada beb cfc>),     "pop";
is str-diff(<aaaa zzzz mmmm aaba>), "aaba";
is str-diff(<aceg bdfh cegi azbz>), "azbz";

sub str-diff(@words)
{ 
    my @diff = @words.head(3).map(&ord-diff);

    my $uniq = [(^)] @diff;
 
    return @words[ @diff.head(3).first(* eq $uniq, :k) ] if $uniq;

    for @words[3..*] -> $w
    {
        return $w unless ord-diff($w) eq @diff.head
    }

    sub ord-diff($str)
    {
        $str.comb.rotor(2 => -1).map({ .tail.ord - .head.ord }).join('-')
    }
}

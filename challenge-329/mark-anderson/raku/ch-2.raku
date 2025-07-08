#!/usr/bin/env raku
use Test;

is-deeply nice-strings("YaaAho"), ("aaA",);
is-deeply nice-strings("cC"),     ("cC",);
is-deeply nice-strings("A"),      (~Empty,);
is-deeply nice-strings("abcdHeEeeFhFfgGhIJJklmabcdefgHIJKLMNOpPqqQrRrrrrrs"),
                      ("HeEeeFhFfgGh", "pPqqQrRrrrrr");

sub nice-strings(Str $s)
{
    sub nice-strings(Int $n)
    {
        ($s ~~ m:ov/. . ** {$n} ./).grep(
        {
            my %c = .comb
                    .unique
                    .classify({ $_ ~~ 'a'..'z' ?? 'lower' 
                                               !! 'upper' }, :as{ .lc });
            %c<lower> (==) %c<upper>
        }) 
    }

    quietly 
    ($s.chars-2...0)
    .map(&nice-strings)
    .first(*.so)
    .map(~*) || (~Empty,) 
}

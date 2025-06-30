#!/usr/bin/env raku
use Test;

is replace('a?z'), 'abz';
is replace('pe?k'), 'peak';
is replace('gra?te'), 'grabte'; 
is replace('?abc?d?ef??????????????????????????????????????????????gh?i?jkl?'),
           'babcadaefabcdehijklmnopqrstuvwxyzabcdehijklmnopqrstuvwxghaiajkla';

sub replace($s is copy)
{
    while $s ~~ / (^ || <.lower>) ('?'+) (<.lower> || $) / 
    {
        given $/
        {
            my @q = sort keys ('a'..'z') (-) (~.[0], ~.[2]);
               @q = (|@q xx *).head(.[1].chars);
               $s = .replace-with([~] .[0], |@q, .[2])
        }
    }

    return $s
}

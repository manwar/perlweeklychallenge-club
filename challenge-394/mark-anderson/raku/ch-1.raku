#!/usr/bin/env raku
use Test;

is alternate-case("aAbB"),   0;
is alternate-case("AAbb"),   1;
is alternate-case("AAAbbb"), 3;
is alternate-case("aABb"),   1;
is alternate-case("bBBAaa"), 2;

sub alternate-case($str is copy)
{
    .elems given gather while $str ~~ / .* [ 
                                               [(<:Lu>) (<:Ll>) <:!Lu>] || 
                                               [(<:Ll>) (<:Lu>) <:!Ll>] 
                                           ]  
                                      / -> ($a,$b)
    {
        take $str ~~ s:c($a.from)/$a$b/$b$a/
    }    
}

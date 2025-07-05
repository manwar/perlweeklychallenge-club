#!/usr/bin/env raku
use Test;

is good-string('WeEeekly'), 'Weekly';
is good-string('abBAdD'),   ~Empty;
is good-string('abc'),      'abc';

sub good-string($str is copy)
{
    my @a = flat ('a'..'z' Z~ 'A'..'Z'), ('A'..'Z' Z~ 'a'..'z');

    # @a = < aA bB cC dD eE fF gG hH iI jJ kK lL mM 
    #        nN oO pP qQ rR sS tT uU vV wW xX yY zZ 
    #        Aa Bb Cc Dd Ee Ff Gg Hh Ii Jj Kk Ll Mm 
    #        Nn Oo Pp Qq Rr Ss Tt Uu Vv Ww Xx Yy Zz >;

    loop 
    {
        $str .= subst(/@a/, :g);
        last unless $/
    }

    return $str
}

#!/usr/bin/env raku
use Test;

is reverse-prefix("programming", "g"), "gorpramming"; 
is reverse-prefix("hello", "h"), "hello";
is reverse-prefix("abcdefghij", "h"), "hgfedcbaij"; 
is reverse-prefix("reverse", "s"), "srevere";
is reverse-prefix("perl", "r"), "repl";

sub reverse-prefix($str, $char)
{
    $str.subst(/(.*? $char)/, {$0.flip}) 
}

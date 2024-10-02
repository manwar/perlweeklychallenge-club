#!/usr/bin/raku

sub MAIN(
    Str $str #= a string representation of a number
) {
    grammar Number {
        rule TOP { <number> }
        rule number { <integer> | <decimal> }
        rule integer { <sign>?<digit>+<exponent>? }
        rule decimal { <sign>?<digit>+<decimalpoint><digit>* | <sign>?<decimalpoint><digit>+ }
        rule exponent { <exponentsymbol><integer> }
 
        token sign { <[+ -]> }
        token digit { <[0 .. 9]> }
        token decimalpoint { <[.]> }
        token exponentsymbol { <[e E]> }
    }

    Number.parse($str).so.say;
}

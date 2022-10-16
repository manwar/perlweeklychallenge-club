#!/usr/bin/env raku

sub unicode-makeover ($str) {
    $str.samemark: 'a'
}

multi MAIN (Bool :test($)!) {
    use Test;
    is unicode-makeover('ÃÊÍÒÙ'),'AEIOU';
    is unicode-makeover('âÊíÒÙ'),'aEiOU';
    done-testing;
}

multi MAIN ($str) {
    say unicode-makeover $str
}

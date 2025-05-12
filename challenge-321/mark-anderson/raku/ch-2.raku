#!/usr/bin/env raku
use Test;

ok  backspace-compare('ab#c', 'ad#c'); 
ok  backspace-compare('ab##', 'a#b#'); 
nok backspace-compare('a#b',  'c');

sub backspace-compare($str1, $str2)
{
    sub backspace($s is copy)
    {
        loop
        {
            last unless $s ~~ s/(<lower>+)('#'+) <?{ $0.chars <= $1.chars }>//
        }

        $s 
    } 

    backspace($str1) eq backspace($str2)
}

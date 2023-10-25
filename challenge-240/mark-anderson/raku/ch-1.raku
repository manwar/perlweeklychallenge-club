#!/usr/bin/env raku
use Test;

ok  acronym(<Perl Python Pascal>, 'ppp');
nok acronym(<Perl Raku>,           'rp');
ok  acronym(<Oracle Awk C>,       'oac');

# This solution gives a warning but I don't think it should.

# Whitespace is insignificant in Raku regexes but it gives a warning
# that whitespace is insignificant?

# It only does this when there is 1 whitespace character. 

# For example, 
# say so "I used Photoshop®"   ~~ m:i/   photo shop /;  # OUTPUT: «True␤» 
# from docs.raku.org/language/regexes#Sigspace
# gives a warning but if there are 2 spaces between 'photo' and 'shop' 
# there is no warning.

sub acronym(@a, $ck)  
{
    so $ck ~~ m:i/^ <{ "@a.match(/ <|w> <:Lu> /, :g)" }> $/
}

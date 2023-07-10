#!/usr/bin/env raku
use Test;

ok  additive-number("112358"),              "1,2,2,3,5,8";
nok additive-number("12345"),               "No Solution";
ok  additive-number("199100199"),           "1,99,100,199";
ok  additive-number("4588321981458832199"), "458832198,1,458832199";
ok  additive-number("1321517324981130211"), "13,2,15,17,32,49,81,130,211";

# additional tests taken from zapwai's solution
ok additive-number("12364884132"),       "12,36,48,84,132";
ok additive-number("28101828"),          "2,8,10,18,28";
ok additive-number("7111829"),           "7,11,18,29";
ok additive-number("112358132134"),      "1,1,2,3,5,8,13,21,34";
ok additive-number("12345657910351614"), "123,456,579,1035,1614";
ok additive-number("102420483072"),      "1024,2048,3072";
ok additive-number("21425"),             "21,4,25";
ok additive-number("3105108"),           "3,105,108";

sub additive-number($n)
{
    my $a = $n.substr(0, $_), 
    my $b = $n.substr($_, *) given ($n.chars div 2).succ;

    for (1..$a.chars.succ).combinations(2) -> ($h, $t)
    {
        my $s := $n.substr(0, $h), $n.substr($h, $t-$h), { $^a + $^b } ... * >= $b;
        return True if $s.join.substr(0, $n.chars) eq $n;
    }

    return False
}

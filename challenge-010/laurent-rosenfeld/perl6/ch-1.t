use Test;
plan 45;

say "\nFrom Roman to Arabic";
for < MM 2000 MCM 1900 LXXIII 73 XCIII 93 IC 99 XCIX 99 xv 15> -> $roman, $arabic {
    is from-roman($roman), $arabic, "$roman => $arabic";
}
isnt from-roman("VII"), 8, "OK: VII not equal to 8";
for <12 foo bar MCMA> -> $param {
    dies-ok {from-roman $param}, "Caught exception OK in from-roman: wrong parameter";
}
say "\nFrom Arabic to Roman";
my %test-nums = map { $_[0] => $_[1] }, (
    <19 42 67 90 97 99 429 498 687 938 949 996 2145 3597> Z
    <XIX XLII LXVII XC XCVII XCIX CDXXIX CDXCVIII DCLXXXVII
     CMXXXVIII CMXLIX CMXCVI MMCXLV MMMDXCVII>);
for %test-nums.keys -> $key {
    is to-roman($key.Int), %test-nums{$key}, "$key => %test-nums{$key}";
}
for 0, 4000, "foobar", 3e6 -> $param {
    dies-ok { to-roman $param}, "Caught exception OK in to-roman: wrong parameter";
}
say "\nSome round trips: from Arabic to Roman to Arabic";
for %test-nums.keys.sort -> $key {
    is from-roman(to-roman $key.Int), $key, "Round trip OK for $key";
}
my $upper-bound = 3999;
say "\nSanity check (round trip through the whole range 1 .. $upper-bound range)";

lives-ok {
    for (1..$upper-bound) -> $arabic {
        die "Failed round trip on $arabic" if from-roman(to-roman $arabic) != $arabic;
    }
}, "Passed round trip on the full 1..$upper-bound range";



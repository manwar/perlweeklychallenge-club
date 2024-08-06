use strict; use warnings; use Test::More tests=>3;

sub count {
    local $_ = shift;
    s/ \| .*? \| //xg;
    y/*//
}

is count( $$_{input} ) => $$_{output}
    for { input => "p|*e*rl|w**e|*ekly|",           output => 2 },
        { input => "perl",                          output => 0 },
        { input => "th|ewe|e**|k|l***ych|alleng|e", output => 5 }

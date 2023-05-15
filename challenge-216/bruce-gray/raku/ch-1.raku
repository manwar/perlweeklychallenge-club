sub task1 ( @words, Str $reg --> Seq ) {

    my Set $r = $reg.lc.comb(/<alpha>/).Set;

    return @words.grep: *.lc.comb ⊇ $r;
}

my @tests =
    ( <abc abcd bcd>    , 'AB1 2CD' , <abcd>      ),
    ( <job james bjorg> , '007 JB'  , <job bjorg> ),
    ( <crack road rac>  , 'C7 RA2'  , <crack rac> ),
;
use Test;
plan +@tests;
for @tests -> ( $in_words, $in_reg, $expected ) {
    is    task1($in_words, $in_reg),$expected;
}

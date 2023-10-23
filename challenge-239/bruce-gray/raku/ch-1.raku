my &task1 = *.join eq *.join;


# Alternate phrasings of the same solution:
# my &task1 = { @^s1.join eq @^s2.join };
# sub task1 ( @s1, @s2 --> Bool ) {
#     return @s1.join eq @s2.join;
# }


my @tests =
    ( True  , ( <ab c>    ,  <a bc>    ) ),
    ( False , ( <ab c>    ,  <ac b>    ) ),
    ( True  , ( <ab cd e> , ('abcde',) ) ),
;
use Test; plan +@tests;
for @tests -> ( Bool $expected, @in ) {
    is task1(|@in), $expected;
}

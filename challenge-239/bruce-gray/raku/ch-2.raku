sub task2_via_Set ( Str $allowed, @s --> UInt ) {
    my Set $a = $allowed.comb.Set;

    return +grep { .comb.Set (-) $a  ≡  ∅ }, @s;
}

sub task2_via_Regex ( Str $allowed, @s --> UInt ) {
    return +grep / ^ @($allowed.comb.unique)+ $ /, @s;
}


my @tests =
    ( 2, ( 'ab'  , <ad bd aaab baa badab>     ) ),
    ( 7, ( 'abc' , <a b c ab ac bc abc>       ) ),
    ( 4, ( 'cad' , <cc acd b ba bac bad ac d> ) ),
;
my @subs =
    :&task2_via_Set,
    :&task2_via_Regex,
;
use Test; plan +@tests * +@subs;
for @subs -> ( :key($sub_name), :value($task2) ) {
    for @tests -> ( UInt $expected, @in ) {
        is $task2.(|@in), $expected, "$sub_name @in[0]";
    }
}
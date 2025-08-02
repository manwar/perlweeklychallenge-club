# At least one b, and no a appears after the first b.
sub task2_cont_regex_ladder ( $str --> Bool ) {
    return False unless $str.contains('b');
    return False if $str ~~ / b .* a /;
    return True;
}
sub task2_cont_regex ( $str --> Bool ) {
    return $str.contains('b')
        && $str !~~ / b .* a /;
}
sub task2_index_substr_cont ( $str --> Bool ) {
    my $pos_of_first_b = $str.index('b')
        orelse return False;

    return ! $str.substr($pos_of_first_b).contains('a');
}
sub task2_single_regex ( $str --> Bool ) {
    # return so $str ~~ / ^ <-[b]>* b <-[a]>* $ /;
    # return so $str ~~ / ^ <-[b]>*: b <-[a]>*: $ /;
    return so $str ~~ /:r ^ <-[b]>* b <-[a]>* $ /;
    # Credit jo-37 for seeing (in Perl) that controlling backtracking could improve performance.
    # Raku Ref: https://docs.raku.org/language/regexes#Backtracking_control
}


my @tests =
    ( 'aabb' , True  ),
    ( 'abab' , False ),
    ( 'aaa'  , False ),
    ( 'bbb'  , True  ),
;
my @subs =
    :&task2_cont_regex_ladder,
    :&task2_cont_regex,
    :&task2_index_substr_cont,
    :&task2_single_regex,
;
use Test; plan +@tests * +@subs;
for @subs -> ( :key($sub_name), :value(&task2) ) {
    for @tests -> ( $str, $expected ) {
        is task2($str), $expected, "$sub_name : $str";
    }
}

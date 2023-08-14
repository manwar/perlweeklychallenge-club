# Five solutions.
sub non-lex_reduce_or ( @letters --> Bool ) {
    return not ( [le] @letters or [ge] @letters );
}
sub non-lex_reduce_and ( @letters --> Bool ) {
    return ( ![le] @letters )
        && ( ![ge] @letters );
}
sub non-lex_Set ( @letters --> Bool ) {
    my Set $orders = ( @letters Zleg @letters.skip ).Set;

    return so (Less & More) ∈ $orders;
}
sub non-lex_sort ( @letters --> Bool ) {
    my @s = @letters.sort;

    return @letters !eqv @s.List
        && @letters !eqv @s.reverse.List;
}
sub non-lex_early_escape ( @letters --> Bool ) {
    my Order $dir = Order::Same;
    for @letters.rotor(2 => -1) -> ($a, $b) {
        my Order $o = $a leg $b;
        return True if $dir and $o and $dir != $o;
        $dir ||= $o;
    }
    return False;
}


constant @tests = map { Hash.new: <expected in> Z=> .list },
    ( 1, <abc bce cae> ),
    ( 2, <yxz cba mon> ),
;
constant @sub_pairs =
    :&non-lex_reduce_or,
    :&non-lex_reduce_and,
    :&non-lex_Set,
    :&non-lex_sort,
    :&non-lex_early_escape,
;
use Test;
plan @tests * @sub_pairs;
for @sub_pairs -> ( :key($sub_name), :value(&non-lex) ) {
    my &task1 = { +grep { non-lex(.comb) }, @^ss };

    is task1(.<in>), .<expected>, "$sub_name: {.<in>}" for @tests;
}

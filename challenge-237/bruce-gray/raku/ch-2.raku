sub greatness (@a, @b) { [+] @a Z< @b }

sub task2_permute ( @ns --> UInt ) {
    my &great_vs_nums = &greatness.assuming(@ns);

    return [max] map &great_vs_nums, permutations @ns;
}

sub construct_best_perm ( @descending ) {
    die unless [>=] @descending;

    my @to_use_up = @descending;

    return gather for @descending -> $num {
        take @to_use_up.head > $num
          ?? @to_use_up.shift
          !! @to_use_up.pop;
    }
}
sub task2_construct ( @ns --> UInt ) {
    my @ordered = @ns.sort: -*;

    return greatness( @ordered, construct_best_perm(@ordered) );
}

sub mk_order ( @a --> List ) { @a.antipairs.sort».value }
sub task2_construct_and_show ( @ns --> UInt ) {
    my @order   = mk_order(@ns   ).reverse;
    my @unorder = mk_order(@order);

    my @perm = construct_best_perm(@ns[@order])[@unorder];

    # .say for @perm, @ns, +«(@perm Z> @ns); # For debugging
    return greatness( @ns, @perm );
}



my @tests =
    ( 4, (1, 3, 5, 2, 1, 3, 1) ),
    ( 3, (1, 2, 3, 4) ),


    ( 3, (1, 2, 3, 14) ),   # to spot non-numeric sorting.

    (  6, ( 8,9,5,5,9,4,4,2 ) ),
    # (  6, ( 8,9,5,5,9,4,4,2,5 ) ),
    # (  6, ( 18,19,5,5,19,4,4,2,5 ) ),
;
my @subs =
    permute__ => &task2_permute,
    construct => &task2_construct,
    con_show_ => &task2_construct_and_show
;
use Test; plan @tests * @subs;
for @tests.kv -> $n, ( $expected, @in ) {
    for @subs -> ( :key($sub_name), :value(&task2) ) {
        is task2(@in), $expected, "$sub_name {$n+1} : @in[]";
    }
}

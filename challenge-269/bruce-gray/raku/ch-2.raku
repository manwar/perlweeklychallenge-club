sub task2_basic ( @ns ) {
    my ( $a, $b, @rest ) = @ns;
    my @arr1 = $a;
    my @arr2 = $b;

    # ( @arr1.tail > @arr2.tail ?? @arr1 !! @arr2 ).push($_) for @rest;
    for @rest -> $n {
        if @arr1.tail > @arr2.tail { push @arr1, $n }
        else                       { push @arr2, $n }
    }

    return flat( @arr1, @arr2 );
}
sub task2_single_r_array ( @ns ) {
    my @r = [ @ns[0] ], [ @ns[1] ];

    for @ns.skip(2) -> $n {
        # @r[ (0,1).max({ @r[$_].tail }) ].push: $n;
        @r.max(+*.tail).push: $n;
    }

    return @r».<>.flat;
}
sub task2_binding ( [ $a, $b, *@rest ] ) {
    my @arr1 = $a;
    my @arr2 = $b;

    # ( @arr1, @arr2 ).max( *.tail ).push($_) for @rest;

    for @rest -> $n {
        my @target_array := ( @arr1, @arr2 ).max( *.tail );
        @target_array.push: $n;
    }

    return flat( @arr1, @arr2 );
}
sub task2_live_capture ( [ $a, $b, *@rest ] ) { 
    my @arr1 = $a;
    my @arr2 = $b;

    my @as = ( @arr1, @arr2 );

    for @rest -> $n {
        push @as.max( *.tail ), $n;
    }

    return flat( @arr1, @arr2 );
}
sub task2_three_pointers ( @ns is copy ) {
    my ( $i1, $i2, $i ) = 0, 1, 2; # Wait, $i will always be $i2 + 1, so I will simplify it in the next sub.

    while $i <= @ns.end {
        # say @ns, ( $i1, $i2, $i );
        if @ns[$i1] > @ns[$i2] {
            my $t = @ns.splice($i, 1);
            @ns.splice($i1+1, 0, $t);
            $i1++;
            $i2++;
            $i++;
        }
        else {
            $i2++;
            $i++;
        }
    }

    return @ns.List;
}
sub task2_one_pointer ( @ns is copy ) {
    my $i1 = 0; # $i1 and $i2 divide @ns into three segments

    for @ns.keys.skip(1) -> $i2 {
        if @ns[$i1] > @ns[$i2] {
            @ns.splice( $i1+1, 0, @ns.splice($i2+1, 1) );
            $i1++;
        }
    }

    return @ns.List;
}


constant @subs =
    :&task2_basic,
    :&task2_single_r_array,
    :&task2_binding,
    :&task2_live_capture,
    :&task2_three_pointers,
    :&task2_one_pointer,
;
constant @tests =
    ( ( 2, 1, 3, 4, 5 ) , ( 2, 3, 4, 5, 1 ) ),
    ( ( 3, 2, 4       ) , ( 3, 4, 2       ) ),
    ( ( 5, 4, 3, 8    ) , ( 5, 3, 4, 8    ) ),
;
use Test; plan +@subs * +@tests;
for @subs -> ( :key($sub_name), :value(&task2) ) {
    for @tests -> ( @in, @expected ) {
        is-deeply task2(@in), @expected, "$sub_name : @in[]";
    }
}

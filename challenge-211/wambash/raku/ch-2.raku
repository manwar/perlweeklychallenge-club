#!/usr/bin/env raku

sub average  { @^a.sum / @^a.elems }

sub split-same-average (+@nums) {
    my $average = average @nums;
    my $elems-limit = @nums.elems div 2;

    @nums
    andthen .combinations( 1..$elems-limit )
    andthen .first: { .&average  == $average },
}

multi MAIN (Bool :test($)!) {
    use Test;
    is split-same-average(1, 2, 3, 4, 5, 6, 7, 8), (1,8);
    is split-same-average(1,3), Nil;
    subtest {
        plan 2;
        my @twenty = <
            44531 73257 49118 89580
            25846 88015 19523 99285
            75574 80036 10796 89896
            77776 69138 75824 80610
            47566  1623 20068  5294
        >;
        with split-same-average(@twenty) {
            is .&average, average(@twenty);
            is .elems, @twenty.elems div 2;
        }
    }
    done-testing;
}

multi MAIN (*@nums) {
    say split-same-average @nums
}

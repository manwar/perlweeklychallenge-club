#!/usr/bin/env raku

sub average  { @^a.sum / @^a.elems }

sub split-same-average-reducer ( @acc, $item, :$average, :$elems-limit ) {
    @acc
    andthen .grep: { .elems  < $elems-limit }\
    andthen .map:  { |@^list, $item }\
    andthen .grep: { .&average ≤ $average     }\
    andthen |@acc, |$_
}

sub split-same-average (+@nums) {
    my $average = average @nums;
    my $elems-limit = @nums.elems div 2;

    @nums
    andthen .sort
    andthen (list(),), |$_
    andthen .reduce: {split-same-average-reducer @^acc, $^item, :$average, :$elems-limit }\
    andthen .first: { .&average  == $average },
}

multi MAIN (Bool :test($)!) {
    use Test;
    is split-same-average(1, 2, 3, 4, 5, 6, 7, 8),(4,5);
    is split-same-average(1,3), Nil;
    is split-same-average(<
        44531 73257 49118 89580
        25846 88015 19523 99285
        75574 80036 10796 89896
        77776 69138 75824 80610
        47566  1623 20068  5294
       >),
       <10796 19523 20068 47566 69138 73257 75574 75824 80036 89896>;
    done-testing;
}

multi MAIN (*@nums) {
    say split-same-average @nums
}

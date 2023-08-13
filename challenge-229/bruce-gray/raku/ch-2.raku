# Three solutions.
sub select-set-elements-by-occurrence-count ( &m, @AoA ) {
    return @AoA.map(&unique).Bag.grep(&m)».key;
}
my &task2 = &select-set-elements-by-occurrence-count.assuming( *.value ≥ 2 );


sub task2_concise ( @AoA --> Seq ) {
    return @AoA.map(&unique).Bag.map: { .key if .value >= 2 };
}


sub task2-set-operations ( @AoA --> Seq ) {
    sub found-in-at-least-N-sets ( UInt $N, @a ) {
        return keys [∪] @a.map(*.Set).combinations($N).map({ [∩] .list });
    }
    return found-in-at-least-N-sets(2, @AoA);
}


constant @tests = map { Hash.new: <expected in> Z=> .list },
    ( (   2, 4), ( (1, 1, 2, 4), (2, 4), (4,) ) ),
    ( (1, 2, 4), ( (4, 1), (2, 4), (1, 2)    ) ),

    ( (4, 5)   , ( (4, 5), (4, 5), (4, 5)    ) ),
;
my @sub_pairs =
    :&task2,
    :&task2_concise,
    :&task2-set-operations,
;
use Test;
plan @tests * @sub_pairs;
for @sub_pairs -> ( :key($sub_name), :value($f) ) {
    is $f(.<in>).sort, .<expected>, "$sub_name: {.<in>}" for @tests;
}

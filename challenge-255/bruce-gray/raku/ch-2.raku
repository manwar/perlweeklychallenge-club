sub task2_BagHash ( $banned, $paragraph --> Str ) {
    die unless $banned.words == 1;
    my BagHash $b = $paragraph.comb(/\w+/).BagHash;

    $b{$banned}:delete;

    return $b.max(*.value).key;
}
sub task2_Grep ( $banned, $paragraph --> Str ) {
    die unless $banned.words == 1;

    return $paragraph
        .comb(/\w+/)
        .grep(*.fc ne $banned.fc)
        .Bag
        .max(*.value)
        .key;
}
# Note: the task does not specify what to do for ties, and I did not use .maxpairs to find them.


my @tests = map { %( <expected in_banned in_paragraph> Z=> .list ) },
    ( 'ball', 'hit', 'Joe hit a ball, the hit ball flew far after it was hit.' ),
    ( 'Perl', 'the', 'Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.' ),
;
my @subs =
    :&task2_BagHash,
    :&task2_Grep,
;
use Test; plan +@tests * +@subs;
for @subs -> ( :key($sub_name), :value(&task2) ) {
    for @tests {
        is task2(|.<in_banned in_paragraph>), .<expected>,
            "$sub_name\t{.<in_banned>}";
    }
}

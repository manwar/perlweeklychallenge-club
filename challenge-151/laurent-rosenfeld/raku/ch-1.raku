use v6;

sub min-depth (Str $tree) {
    my @ranks = split /'|'/, $tree;
    return "depth: 1" if @ranks == 1;
    for 1..@ranks.end -> $i {
        my @nodes = @ranks[$i] ~~ m:g/'*' | \d+/;
        return "depth: {$i}" if @nodes.elems + 1 < 2 ** $i and $i == @ranks.end;
        return "depth: {$i+1}" if @nodes.elems + 1 <= 2 ** $i ;
        for (@ranks[$i]).comb(/\S+/) -> $a, $b {
            return "depth: $i" if $a eq $b eq '*';
        }
    return "depth: {$i+1}" if $i == @ranks.end;
    }
}

for '1 ',   '1 |',   '1 | 2 3',
    '1 | 2 3 | 4 5',
    '1 | 2 3 | 4 *  * 5 | * 6',
    '1 | 2 3 | * *  4 5 | * * 6',
    '1 | 2 3 | 4 4 5 6 | 7 8 9 10 11 12 13 14 ',
    '1 | 2 3 | 4 4 5 6 | 7 8 9 10 11 12 13 ',
    '1 | 2 3 | 4 4 5 6 | 7 8 9 10 11 12 '
    -> $test {
    printf "%-45s -> %s\n", "'$test'", min-depth $test
}

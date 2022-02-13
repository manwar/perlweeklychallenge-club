use strict;
use warnings;
use feature "say";

sub min_depth {
    my $tree = shift;
    my @ranks = split /\|/, $tree;
    return "depth: 1" if @ranks == 1;
    for my $i (1..$#ranks) {
        # say $ranks[$i];
        my @nodes = ($ranks[$i] =~ /\*|\d+/g);
        # say "@nodes";
        return "depth: $i" if @nodes + 1 < 2 ** $i and $i == $#ranks;
        return "depth: " . ($i+1) if @nodes + 1 <= 2 ** $i ;
        my $j = 0;
        while ($j <= $#nodes) {
            return "depth: $i" if $nodes[$j] eq '*' and $nodes[$j+1] eq '*';
            $j += 2;
        }
        return "depth: ". ($i + 1) if $i + 1 == @ranks;
    }
}

for my $test ( '1 ',   '1 |',   '1 | 2 3',
    '1 | 2 3 | 4 5',
    '1 | 2 3 | 4 *  * 5 | * 6',
    '1 | 2 3 | * *  4 5 | * * 6',
    '1 | 2 3 | 4 4 5 6 | 7 8 9 10 11 12 13 14 ',
    '1 | 2 3 | 4 4 5 6 | 7 8 9 10 11 12 13 ',
    '1 | 2 3 | 4 4 5 6 | 7 8 9 10 11 12 ' ) {
        printf "%-42s -> %s\n", "$test", min_depth($test);
}

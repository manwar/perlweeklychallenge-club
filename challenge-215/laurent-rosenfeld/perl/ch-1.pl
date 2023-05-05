use strict;
use warnings;
use feature 'say';

sub find_non_sorted {
    my @in = @_;
    my @out = $in[0];
    my $count = 0;
    for my $i (1..$#in) {
        if ($in[$i] lt $in[$i-1]) {
            $count++;
        } else {
            push @out, $in[$i];
        }
    }
    # say @out;
    return $count;
}

for my $test ([<abc xyz tsu>], [<rat cab dad>], [<x y z>]) {
    printf "%-15s => ", "@$test";
    say find_non_sorted @$test;
}

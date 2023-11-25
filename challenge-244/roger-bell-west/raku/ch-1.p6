#! /usr/bin/raku

use Test;

plan 3;

is-deeply(countsmaller([8, 1, 2, 2, 3]), [4, 0, 1, 1, 3], 'example 1');
is-deeply(countsmaller([6, 5, 4, 8]), [2, 1, 0, 3], 'example 2');
is-deeply(countsmaller([2, 2, 2]), [0, 0, 0], 'example 3');

sub countsmaller(@nums) {
    my @b = @nums.sort({$^a <=> $^b});
    my %sm;
    my $l = 0;
    for 0 .. @b.end -> $i {
        my $e = @b[$i];
        if ($i == 0 || $e != $l) {
            %sm{$e} = $i;
            $l = $e;
        }
    }
    return Array(@nums.map({%sm{$_}}));
}

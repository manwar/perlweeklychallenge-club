use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub permute(@items) {
    return ([[ @items ]]) if @items <= 1;

    my @result;

    for my $i (0 .. $#items) {
        my @rest = @items[0 .. $i-1, $i+1 .. $#items];
        for my $p (@{ permute(@rest) }) {
            push @result, [ $items[$i], @$p ];
        }
    }

    return \@result;
}

sub run($source, $target) {
    my @source_strings = map { join ("", @{$_}) } @$source;
    my $target_string = join("", @$target);

    my $permutations = permute(@source_strings);
    foreach my $permutation (@$permutations) {
        my $work = $target_string;
        foreach my $s (@$permutation) {
            $work =~ s/$s//;
        }
        return 1 if length($work) == 0;
    }
    return 0;
}

is(run([[2,3], [1], [4]], [1, 2, 3, 4]), 1, "Example 1");
is(run([[1,3], [2,4]], [1, 2, 3, 4]), 0, "Example 2");
is(run([[9,1], [5,8], [2]], [5, 8, 2, 9, 1]), 1, "Example 3");
is(run([[1], [3]], [1, 2, 3]), 0, "Example 4");
is(run([[7,4,6]], [7, 4, 6]), 1, "Example 5");
is(run([[1,2,3],[4],[5,6],[1,2],[3,4,5]], [1,2,3,4,5,1,2,3,4,5,6]), 1, "Example from \@choroba");

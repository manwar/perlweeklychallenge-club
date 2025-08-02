# Solution to Task 2 of The Weekly Challenge 263
# https://theweeklychallenge.org/blog/perl-weekly-challenge-263/#TASK2

# $ raku ch-2.raku
# [(1 4) (2 3) (3 2)]

my @items1 = [[1, 1], [2, 1], [3, 2]];
my @items2 = [[2, 2], [1, 3]];

my %values;
for (@items1, @items2).flat -> ($k, $v) {
    %values{$k} += $v;
}

my @result = (%values.keys.sort: {$^a <=> $^b}).map: {$_, %values{$_}};
say @result;

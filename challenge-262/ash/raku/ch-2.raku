# Solution to Task 2 of The Weekly Challenge 262
# https://theweeklychallenge.org/blog/perl-weekly-challenge-262/#TASK2

# Test run:
# $ raku ch-2.raku
# 4

my @ints = 3, 1, 2, 2, 2, 1, 3;
my $k = 2;

# my @ints = 1, 2, 3;
# my $k = 1;

my $count = 0;
for ^@ints -> $j {
    for ^$j -> $i {
        next unless @ints[$i] == @ints[$j];
        $count++ if ($j * $i) %% $k;
    }
}

say $count;

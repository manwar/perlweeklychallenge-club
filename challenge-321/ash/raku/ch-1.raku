# Task 1 of the Weekly Challenge 321
# https://theweeklychallenge.org/blog/perl-weekly-challenge-321/#TASK1

my @nums = 1, 2, 4, 3, 5, 6; # 1
# my @nums = 0, 2, 4, 8, 3, 5; # 2
# my @nums = 7, 3, 1, 0, 5, 9; # 2

my @avg = gather {
    while (@nums) {
        my $min = @nums.min;
        my $max = @nums.max;

        my $avg = ($min + $max) / 2;
        take $avg;

        @nums.=grep: * ∉ (@nums.min, @nums.max);
    }
}

say @avg.unique.elems;

#!/usr/bin/env raku

# Task 2 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-073/

# Comments: https://andrewshitov.com/2020/08/10/raku-challenge-week-73/

my @a = 7, 8, 3, 12, 10;

say @a[$_] < min(@a[^$_]) ?? 0 !! min(@a[^$_]) for ^@a;

# Output: 
# $ raku ch-2.raku 
# 0
# 7
# 0
# 3
# 3


# Uncomment to see the process:

# for ^@a {
#     say @a[^$_];
#     my $current = @a[$_];
#     my $min = min(@a[^$_]);
#     say "Min: $min";
#     say "Current $current";

#     if $current < $min {
#         say 0;
#     }
#     else {
#         say $min;
#     }
# }

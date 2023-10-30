use v5.30;
my @ints = (1,2,3,4,5);
my @sum;
push @sum, $sum[$#sum] + $ints[$_] for (0 .. $#ints);
say "Input: \@ints = (" . join(", ", @ints) . ")";
say "Output: \@sum = (" . join(", ", @sum) . ")";

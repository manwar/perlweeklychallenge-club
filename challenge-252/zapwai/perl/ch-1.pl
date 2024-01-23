use v5.30;
my @ints = (1,2,3,4);
#@ints = (2, 7, 1, 19, 18, 3);
my $n = scalar @ints;
my @special = grep { $n % ($_+1) == 0 } (0 .. $#ints);
my $sum = 0;
$sum += $ints[$_]**2 for ( @special );
say "Input: \@ints = @ints";
say "Output: $sum";
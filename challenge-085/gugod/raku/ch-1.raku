my @nums = @*ARGS.map: *.Num;

my $so = @nums.combinations(3).first({ 1 < .sum < 2 });

say $so ?? 1 !! 0;

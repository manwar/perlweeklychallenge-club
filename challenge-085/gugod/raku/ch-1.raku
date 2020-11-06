my @nums = @*ARGS.map: *.Num;

my $so = @nums.combinations(3)o.first({ 1 < .sum < 2 });

if $so {
    say 1;
} else {
    say 0;
}

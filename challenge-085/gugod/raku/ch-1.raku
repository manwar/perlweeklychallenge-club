my @nums = @*ARGS.map: *.Num;

my @combo = @nums.combinations(3).first({ 1 < .sum < 2 });

if @combo.elems == 3 {
    say "1 as 1 < { @combo.join(' + ') } < 2";
} else {
    say 0;
}

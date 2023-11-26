sub count-reverse-pairs(@nums) {
    merge-sort(0, @nums.elems - 1, @nums)
}

sub merge-sort($left, $right, @nums) {
    return 0 if $left >= $right;

    my $mid = ($left + $right) div 2;
    my $count = merge-sort($left, $mid, @nums) + merge-sort($mid + 1, $right, @nums);

    # Count reverse pairs
    my ($i, $j) = ($left, $mid + 1);
    while ($i <= $mid) {
        $j++ while ($j <= $right && @nums[$i] > 2 * @nums[$j]);
        $count += $j - ($mid + 1);
        $i++;
    }

    # Merge step
    my @sorted;
    ($i, $j) = ($left, $mid + 1);
    while ($i <= $mid && $j <= $right) {
        if (@nums[$i] <= @nums[$j]) {
            @sorted.push(@nums[$i++]);
        } else {
            @sorted.push(@nums[$j++]);
        }
    }
    @sorted.append(@nums[$i..$mid]) if $i <= $mid;
    @sorted.append(@nums[$j..$right]) if $j <= $right;
    @nums[$left..$right] = @sorted;

    return $count;
}

# Testing with example inputs
say count-reverse-pairs(1, 3, 2, 3, 1); # Output: 2
say count-reverse-pairs(2, 4, 3, 5, 1); # Output: 3

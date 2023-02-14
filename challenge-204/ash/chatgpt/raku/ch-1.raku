# This program has been created by ChatGPT
#
# Test run:
# $ raku ch-1.raku 
# 1
# 0
# 1

sub is_monotonic(@nums) {
    my $increasing = True;
    my $decreasing = True;
    for (0 ..^ @nums.end) -> $i {
        for ($i + 1 .. @nums.end) -> $j {
            if (@nums[$i] > @nums[$j]) {
                $increasing = False;
            }
            if (@nums[$i] < @nums[$j]) {
                $decreasing = False;
            }
        }
    }
    return 1 if $increasing || $decreasing;
    return 0;
 }

my @nums = (1, 2, 2, 3);
say is_monotonic(@nums);

@nums = (1, 3, 2);
say is_monotonic(@nums);

@nums = (6, 5, 5, 4);
say is_monotonic(@nums);

use strict;
use warnings;
use feature "say";

my $best_so_far;

sub get_best {
    my $sum_so_far = $_[0];
    my @in = @{$_[1]};

    if (@in <= 2)  {
        $sum_so_far += $in[0] if @in == 1;
        $sum_so_far += $in[1] if @in == 2;
        $best_so_far = $sum_so_far if $sum_so_far > $best_so_far;
        return;
    }
    for my $i (0, 1) {
        get_best($sum_so_far + $in[$i], [@in[$i + 2 .. $#in]]);
    }
}

my @valuables = ([2, 4, 5], [4, 2, 3, 6, 5, 3], [4, 2, 5, 10]);
for my $test (@valuables) {
    $best_so_far = 0;
    get_best 0, $test;
    say "@$test -> ", $best_so_far;
}

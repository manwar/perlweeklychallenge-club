use strict;
use warnings;
use feature qw/say/;


sub equalize {
    my @nums = @{$_[0]};
    my $sum = 0;
    $sum += $_ for @nums;
    return -1 if $sum % scalar @nums;
    my $target = $sum / scalar @nums;
    my $count = 0;
    my $carry = 0;
    for my $num (@nums) {
        $num -= $carry;
        $carry = $target - $num;
        $count += abs $carry;
    }
    return $count;
}
for my $test ([<1 0 5>], [<0 2 0>], [<0 3 0>],
              [<3 0 3>], [<2 2 2>], [<1 0 5 2>],
              [<2 5 0 1>], [<1 0 5 3>], [<6 0 0>]) {
    say "@$test\t -> ", equalize $test;
}

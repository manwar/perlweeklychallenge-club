use strict;
use warnings;
use feature qw/say/;

for my $test ([5, 2, 9, 1, 7, 6], [4, 2, 3, 1, 5, 0]) {
    my @nums = @{$test};
    my ($max_i, $max_n) = (0, 0);
    for my $i (0..$#nums) {
        if ($nums[$i] > $max_n) {
            $max_n = $nums[$i];
            $max_i = $i;
        }
    }
    say "@nums : $max_i => $max_n";
}

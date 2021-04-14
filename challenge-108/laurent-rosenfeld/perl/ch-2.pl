use strict;
use warnings;
use feature "say";
use constant MAX => 9;

my @tr;
$tr[0][0] = 1;
for my $row (1..MAX) {
    $tr[$row][0] = $tr[$row - 1][-1];
    for my $i (1..$row) {
        $tr[$row][$i] = $tr[$row][$i-1] + $tr[$row - 1][$i-1];
    }
}
say join " ", map { $tr[$_][0] } 0..$#tr;

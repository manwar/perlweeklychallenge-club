use strict;
use warnings;
use feature "say";

sub dupe_and_missing {
    my @nums = @_;
    my ($dupe, $missing);
    for my $i (1..$#nums) {
        if ($nums[$i] == $nums[$i-1]) {
            $dupe = $nums[$i];
        } elsif ($nums[$i] - $nums[$i-1] != 1) {
            $missing = $nums[$i-1] + 1;
        }
    }
    return "($dupe, $missing)" if $dupe and $missing;
    return "-1" unless $dupe or $missing;
    return "($dupe, -)" if $dupe;
    return "(-, $missing)";
}

for my $test ([<1 2 2 4>], [<1 2 3 4>], [<1 2 3 3>],
    [<1 2 4 5>], [<1 1 3 4>], [<1 3 4 5>], [<1 2 2 3 5>]) {
    printf "%-12s => ", "@$test";
    say dupe_and_missing @$test;
}

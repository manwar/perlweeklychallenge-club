use strict;
use warnings;
use feature 'say';


sub complete_day {
    my @in = @_;
    my $count = 0;
    for my $i (0..$#in) {
        for my $j ($i+1..$#in) {
            $count++ if ($in[$i] + $in[$j]) % 24 == 0;
        }
    }
    return $count;
}

my @tests = ([<12 12 30 24 24>], [<72 48 24 5>], [<12 18 24>]);
for my $test (@tests) {
    printf "%-15s => ", "@$test";
    say complete_day @$test;
}

use strict;
use warnings;
use feature 'say';

sub last_member {
    my @in = sort { $b <=> $a } @_;
    while (@in > 1) {
        @in = $in[0] == $in[1] ?
            sort { $b <=> $a } @in[2..$#in] :
            sort { $b <=> $a } ($in[1] - $in[0], @in[2..$#in]);
        # say "@in"; # uncomment to view the steps
    }
    return scalar @in;
}

for my $test ([2, 7, 4, 1, 8, 1], [1], [1, 1]) {
    printf "%-12s => ", "@$test";
    say last_member @$test;
}

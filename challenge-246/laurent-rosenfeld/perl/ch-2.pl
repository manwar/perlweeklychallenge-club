use strict;
use warnings;
use feature 'say';

sub linear_rec {
    my @in = @_;
    my ($min, $max) = (sort {$a <=> $b} @in)[0, -1];
    for my $p ($min .. $max) {
        for my $q ($min .. $max) {
            for my $i (2..$#in) {
                last if $in[$i] !=
                    $p * $in[$i-2] + $q * $in[$i-1];
                # say "$p $q $i";
                return ("True:  p = $p, q = $q")
                    if $i == $#in;
            }
        }
    }
    return "False";
}

my @tests = ([<1 1 2 3 5>], [<4 2 4 5 7>], [<4 1 2 -3 8>]);
for my $test (@tests) {
    printf "%-12s => ", "@$test";
    say linear_rec @$test;
}

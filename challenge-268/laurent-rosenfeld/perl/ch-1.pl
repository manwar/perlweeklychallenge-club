use strict;
use warnings;
use feature 'say';

sub magic_nr  {
    my @in1 = sort {$a<=>$b} @{$_[0]};
    my @in2 = sort {$a<=>$b} @{$_[1]};
    my $gap = $in1[0] - $in2[0];
    for my $i (1..$#in1) {
        return "undef" if $in1[$i] - $in2[$i] != $gap;
    }
    return abs $gap;
}

my @tests = ([[<3 7 5>], [<9 5 7>]], [[<1 2 1>], [<5 4 4>]],
             [[2,], [5]], [[<3 7 5>], [<6 5 7>]] );

for my $test (@tests) {
    printf "%-6s - %-6s => ", "@{$test->[0]}", "@{$test->[1]}";
    say magic_nr $test->[0], $test->[1];
}

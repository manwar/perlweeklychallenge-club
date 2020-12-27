use strict;
use warnings;
use feature "say";
use Data::Dumper;

my @tests = ([[2, 6], [1, 4], [8, 10]], [[5, 8], [1, 2], [3,7 ], [8, 10]], [[10, 11], [1, 5], [7, 9]]);

for my $test (@tests) {
    say join " ", map { "[ @$_ ]" } @$test;
    my @sorted = sort { $a->[0] <=> $b->[0] } @$test;
    say join " ", map { "[ @$_ ]" } @sorted;
    my @result;
    my $first = shift @sorted;
    my ($start, $end) = @$first;
    for my $item (@sorted) {
        # say "[$item] $start $end ", @result;
        if ($item->[0] > $end) {
            push @result, [$start, $end];
            # say "Temp res = ", @result;
            ($start, $end) = @$item;
        } else {
            $end = $item->[1];
        }
    }
    push @result, [$start, $end] unless $start == $result[-1][0];
    say "result = ", join (" ", map { "[ @$_ ]" } @result), "\n";
}

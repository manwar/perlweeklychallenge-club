use strict;
use warnings;
use feature 'say';

sub zero_sum {
    my $n = shift;
    my @result;
    for my $i (1.. int $n/2) {
        push @result, ($i, -$i);
    }
    push @result, 0 if $n % 2;
    return @result;
}
for my $test (3, 4, 5,  1) {
    say "$test => ", join " ", zero_sum $test;
}

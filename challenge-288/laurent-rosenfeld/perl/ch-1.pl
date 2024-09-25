use strict;
use warnings;
use feature 'say';

sub closest_palindrome {
    my $in = shift;
    my $i = 1;
    while (1) {
        return $in - $i if reverse($in - $i) eq $in - $i;
        return $in + $i if reverse($in + $i) eq $in + $i;
        $i++;
    }
}

my @tests = (123, 2, 1400, 1001);
for my $test (@tests) {
    printf "%-6d => ", $test;
    say closest_palindrome $test;
}

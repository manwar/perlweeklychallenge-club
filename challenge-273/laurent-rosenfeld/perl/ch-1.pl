use strict;
use warnings;
use feature 'say';

sub percent {
    my ($str, $char) = @_;
    my $count = 0;
    for my $ch (split //, $str) {
        $count++ if $ch eq $char;
    }
    return int (0.5 + ($count * 100) / (length $str));
}

my @tests = ( [<perl e>], [<java a>], [<python m>],
            [<ada a>], [<ballerina l>], [<analitik k>] );
for my $test (@tests) {
    printf "%-10s - %-2s => ", $test->[0], $test->[1];
    say percent @$test;
}

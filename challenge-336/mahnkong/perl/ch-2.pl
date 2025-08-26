use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@scores) {
    my $total = 0;
    my @result;

    foreach my $score (@scores) {
        if ($score =~ /^[+-]?\d+$/) {
            push @result, $score;
        } elsif ($score eq 'D') {
            push @result, $result[-1]*2;
        } elsif ($score eq '+') {
            push @result, $result[-2] + $result[-1];
        } elsif ($score eq 'C') {
            delete $result[-1];
        }
    }

    map { $total += $_ } @result;
    return $total;
}

is(run("5","2","C","D","+"), 30, "Example 1");
is(run("5","-2","4","C","D","9","+","+"), 27, "Example 2");
is(run("7","D","D","C","+","3"), 45, "Example 3");
is(run("-5","-10","+","D","C","+"), -55, "Example 4");
is(run("3","6","+","D","C","8","+","D","-2","C","+"), '128', "Example 5");

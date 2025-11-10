use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($str) {
    my @candidates;
    foreach my $c (split //, $str) {
        my $open = 0;
        if ($c eq '(') {
            push @candidates, {
                open => 0,
                found => 0,
            };
            $open = 1;
        } elsif ($c eq ')') {
            $open = -1;
        }
        foreach my $candidate (@candidates) {
            next unless exists $candidate->{open};
            $candidate->{found} += 1;
            $candidate->{open} += $open;
            if ($candidate->{open} == 0) {
                push @candidates, {
                    found => $candidate->{found},
                }
            }
        }
    }

    my $result = 0;
    foreach my $candidate (@candidates) {
        $result = $candidate->{found} if ! exists $candidate->{open} && $candidate->{found} > $result;
    }
    return $result;
}

is(run('(()())'), 6, "Example 1");
is(run(')()())'), 4, "Example 2");
is(run('((()))()(((()'), 8, "Example 3");
is(run('))))((()('), 2, "Example 4");
is(run('()(()'), 2, "Example 5");

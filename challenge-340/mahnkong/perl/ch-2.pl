use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($string) {
    my $last;
    while ($string =~ /(\d+)/g) {
        if (defined $last && $last >= $1) {
            return 0;
        }
        $last = $1;
    }
    defined $last ? 1 : 0;
}

is(run("The cat has 3 kittens 7 toys 10 beds"), 1, "Example 1");
is(run("Alice bought 5 apples 2 oranges 9 bananas"), 0, "Example 2");
is(run("I ran 1 mile 2 days 3 weeks 4 months"), 1, "Example 3");
is(run("Bob has 10 cars 10 bikes"), 0, "Example 4");
is(run("Zero is 0 one is 1 two is 2"), 1, "Example 5");
is(run("Keine einzige Nummer"), 0, "Example 6");
is(run("Nur 1 Nummer"), 1, "Example 7");

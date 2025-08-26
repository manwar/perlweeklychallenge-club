use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@ints) {
    for (my $i = scalar(@ints)/2; $i >= 2; $i--) {
        if (scalar(@ints) % $i == 0) {
            my @work = @ints;

            my $valid = 1;
            while (scalar(@work)) {
                my %values;
                foreach my $v (splice(@work, 0, $i)) {
                    $values{$v} = 1;
                }
                $valid = 0 if scalar(keys(%values)) != 1;
            }
            return 1 if $valid;
        }
    }
    return 0;
}

is(run(1,1,2,2,2,2), 1, "Example 1");
is(run(1,1,1,2,2,2,3,3), 0, "Example 2");
is(run(5,5,5,5,5,5,7,7,7,7,7,7), 1, "Example 3");
is(run(1,2,3,4), 0, "Example 4");
is(run(8,8,9,9,10,10,11,11), 1, "Example 5");

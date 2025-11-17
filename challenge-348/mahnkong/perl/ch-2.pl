use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

my @operations = (1, 5, 15, 60);

sub get_minutes($str, $is_target = 0) {
    my @parts = split /:/, $str;
    if ($is_target && $parts[0] eq "00") {
        $parts[0] = "24";
    }
    my $m = $parts[0]*60 + $parts[1];
    return $m;
}

sub run($source, $target) {
    my $diff = get_minutes($target, 1) - get_minutes($source);
    my $operations = 0;
    while ($diff > 0) {
        foreach my $o (reverse(@operations)) {
            if ($diff >= $o) {
                $diff -= $o;
                $operations += 1;
                last;
            }
        }
    }
    return $operations;
}

is(run("02:30", "02:45"), 1, "Example 1");
is(run("11:55", "12:15"), 2, "Example 2");
is(run("09:00", "13:00"), 4, "Example 3");
is(run("23:45", "00:30"), 3, "Example 4");
is(run("14:20", "15:25"), 2, "Example 5");

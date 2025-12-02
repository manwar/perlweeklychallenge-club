use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($from, $to, $count) {
    my $result = 0;
    for (my $i = $from; $i <= $to; $i++) {
        my $max = join("", sort({$b <=> $a} split//, $i));
        next if $max < $i*2;

        my $j = $max;
        while ($j >= $i*2) {
            last if $i == $j;
            my $left = $j % $i;
            $j = $j - $left;
            unless (join("", sort({$b <=> $a} split//, $j)) eq $max) {
                $j -= 1;
                next;
            }
            if ($j / $i >= $count) {
                my $current_counts = 0;
                for (my $k = $j/$i; $k > 1; $k--) {
                    if (join("", sort({$b <=> $a} split//, $k*$i)) eq $max) {
                        $current_counts += 1;
                    }
                }
                if ($current_counts >= $count) {
                    print "$i -> $j (" . $current_counts . ")\n";
                    $result += 1;
                }
            }
            last;
        }
    }
    return $result;
}

is(run(1, 1000, 1), 0, "Example 1");
is(run(1500, 2500, 1), 3, "Example 2");
is(run(1_000_000, 1_500_000, 5), 2, "Example 3");
is(run(13_427_000, 14_100_000, 2), 11, "Example 4");
is(run(1030, 1130, 1), 2, "Example 5");

#! /usr/bin/perl6

use Test;

plan 4;

is-deeply(daystogether(["12-01", "20-01"], ["15-01", "18-01"]),
          4,
          'example 1');

is-deeply(daystogether(["02-03", "12-03"], ["13-03", "14-03"]),
          0,
          'example 2');

is-deeply(daystogether(["02-03", "12-03"], ["11-03", "15-03"]),
          2,
          'example 3');

is-deeply(daystogether(["30-03", "05-04"], ["28-03", "02-04"]),
          4,
          'example 4');

sub daystogether(@a,@b) {
    my @starts = [s2date(@a[0]), s2date(@b[0])].sort;
    my @ends = [s2date(@a[1]), s2date(@b[1])].sort;
    if (@ends[0] > @starts[1]) {
        return @ends[0]-@starts[1]+1;
    } else {
        return 0;
    }
}

sub s2date($ds) {
    if ($ds ~~ /^(\d+)\-(\d+)$/) {
        return Date.new(year => 2022,
                        month => $1,
                        day => $0);
    }
    die "$ds is not a recognisable date\n";
}

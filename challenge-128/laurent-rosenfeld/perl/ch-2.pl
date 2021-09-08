use strict;
use warnings;
use feature qw/say/;

my @arrivals   = qw<10:20 11:00 11:10 12:20 16:20 19:00>;
my @departures = qw<10:30 13:20 12:40 12:50 20:20 21:20>;
my @ts_arr = map { my ($m, $s) = split /:/, $_; $m * 60 + $s;} @arrivals;
my @ts_dep = map { my ($m, $s) = split /:/, $_; $m * 60 + $s;} @departures;
my $size = 0;
my $max_size = 0;
while (@ts_arr) {
    if ($#ts_dep == 0) {
        $max_size++;
    } elsif ($ts_arr[0] <= $ts_dep[0]) {
        shift @ts_arr;
        $size++;
        $max_size = $size if $size > $max_size;
        # say "$size $max-size";
    } else {
        shift @ts_dep;
        $size--;
    }
}
say $max_size;

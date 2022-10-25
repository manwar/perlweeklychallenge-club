use strict;
use warnings;
use feature qw/say/;

my @months = < 0 31 28 31 30 31 30 31 31 30 31 30 31 >;
my @dates;
for my $m (map {sprintf( "%02d", $_ ) } 1..12) {
    push @dates, map {sprintf ( "%02d-$m", $_ )} 1..$months[$m];
}
my $c = 1;
my %d = map { $_ => $c++ } @dates;

sub compute_common {
    my ($sd1, $ed1, $sd2, $ed2) = map $d{$_}, @_;
    my $start_common = $sd1 > $sd2 ? $sd1 : $sd2;
    my $end_common   = $ed1 < $ed2 ? $ed1 : $ed2;
    return $end_common - $start_common + 1;
}

for my $test (
    [<12-01 20-01 15-01 18-01>], [<03-03 12-03 13-03 14-03>],
    [<02-03 12-03 11-03 15-03>], [<30-03 05-04 28-03 02-04>],
    [<12-01 13-03 09-01 25-04>] ) {
        say "Number of days together for dates @$test]: ",
            compute_common @$test;
}
